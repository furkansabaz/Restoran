//
//  AppDelegate.swift
//  Restoran
//
//  Created by Furkan Sabaz on 5.06.2019.
//  Copyright © 2019 Furkan Sabaz. All rights reserved.
//

import UIKit
import Moya
import CoreLocation
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    //var window: UIWindow?
    
    let window = UIWindow()
    let konumServis = KonumServis()
    let storyBoard = UIStoryboard(name: "Main", bundle: nil)
    
    let decoder = JSONDecoder()
    var navigationController : UINavigationController?
    
    let agServis = MoyaProvider<YelpServis.VeriSaglayici>()
    
    
    var aramaFiltresi : String? {
        didSet {
            if self.aramaFiltresi!.isEmpty {
                self.isYerleriniGetir(koordinat: konumServis.gecerliKonum!)
            } else {
                self.isYerleriniGetir(koordinat: konumServis.gecerliKonum!, aramaFiltre: self.aramaFiltresi!)
            }
        }
    }
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        konumServis.yeniKonum = { sonuc in
            switch sonuc {
            case .basarili(let konumBilgisi) :
                print(konumBilgisi.coordinate.latitude,"-",konumBilgisi.coordinate.longitude)
                
                self.isYerleriniGetir(koordinat: konumBilgisi.coordinate)
            case .hatali(let hata) :
                //assertionFailure("Hata Meydana Geldi : \(hata)")
                print("Hatalı")
            }
            
        }
        
        
        switch konumServis.durum {
            
        case .denied, .notDetermined, .restricted  :
            let konumVC = storyBoard.instantiateViewController(withIdentifier: "KonumViewController") as? KonumViewController
            konumVC?.delegeate = self
            window.rootViewController = konumVC
            default :
            
                let navigation = storyBoard.instantiateViewController(withIdentifier: "RestoranNavigationController") as? UINavigationController
            window.rootViewController = navigation
                navigationController = navigation
            //isYerleriniGetir()
            konumServis.konumAl()
            (navigation?.topViewController as? RestoranlarTableViewController)?.delegate = self
            }
        window.makeKeyAndVisible()
        
        return true
    }

    private func detaylariGetir(viewController : UIViewController,mekanId : String) {
        agServis.request(.details(id: mekanId)) { (sonuc) in
            
            switch sonuc {
            case .success(let veri):
                if let detaylar = try? self.decoder.decode(Details.self, from: veri.data) {
                    let restoranDetaylari = DetaylarView(detay: detaylar)
                    
                    let yemekDetaylariVC = (viewController as? YemekDetaylariViewController)
                    yemekDetaylariVC?.restoranDetaylari = restoranDetaylari
                    yemekDetaylariVC?.delegate = self
                }
                
            case .failure(let hata) :
                print("Hata Meydana Geldi  :\(hata)")
            }
        }
    }
    private func isYerleriniGetir(koordinat : CLLocationCoordinate2D) {
        agServis.request(.search(lat: koordinat.latitude, long: koordinat.longitude)) { (sonuc) in
            switch sonuc {
            case .success(let gelenVeri) :
                
                
                self.decoder.keyDecodingStrategy = .convertFromSnakeCase
                let veri = try? self.decoder.decode(TumVeri.self, from: gelenVeri.data)
                let restoranlarListesi = veri?.businesses.compactMap(RestoranListViewModel.init).sorted(by: {   $0.uzaklik < $1.uzaklik   })
                
                if let navigation = self.window.rootViewController as? UINavigationController, let restoranlarTableViewController = navigation.topViewController as? RestoranlarTableViewController {
                    restoranlarTableViewController.restoranlarListesi = restoranlarListesi ?? []
                } else if let navigation1 = self.storyBoard.instantiateViewController(withIdentifier: "RestoranNavigationController") as? UINavigationController {
                    
                    self.navigationController = navigation1
                    
                    self.window.rootViewController?.present(navigation1, animated: true) {
                        (navigation1.topViewController as? RestoranlarTableViewController)?.delegate = self
                        print("Restoran Listesi Eleman Sayısı : \(restoranlarListesi?.count)")
                        (navigation1.topViewController as? RestoranlarTableViewController)?.restoranlarListesi = restoranlarListesi ?? []
                        
                    }
                }
            case .failure(let hata) :
                print("Hata Meydana Geldi : \(hata)")
            }
        }
        
    }
    
    
    private func isYerleriniGetir(koordinat : CLLocationCoordinate2D, aramaFiltre : String) {
        agServis.request(.searchFilter(lat: koordinat.latitude, long: koordinat.longitude, filter : aramaFiltre)) { (sonuc) in
            switch sonuc {
            case .success(let gelenVeri) :
                
                
                self.decoder.keyDecodingStrategy = .convertFromSnakeCase
                let veri = try? self.decoder.decode(TumVeri.self, from: gelenVeri.data)
                let restoranlarListesi = veri?.businesses.compactMap(RestoranListViewModel.init).sorted(by: {   $0.uzaklik < $1.uzaklik   })
                
                if let navigation = self.window.rootViewController as? UINavigationController, let restoranlarTableViewController = navigation.topViewController as? RestoranlarTableViewController {
                    restoranlarTableViewController.restoranlarListesi = restoranlarListesi ?? []
                } else if let navigation1 = self.storyBoard.instantiateViewController(withIdentifier: "RestoranNavigationController") as? UINavigationController {
                    
                    self.navigationController = navigation1
                    
                    self.window.rootViewController?.present(navigation1, animated: true) {
                        (navigation1.topViewController as? RestoranlarTableViewController)?.delegate = self
                        print("Restoran Listesi Eleman Sayısı : \(restoranlarListesi?.count)")
                        (navigation1.topViewController as? RestoranlarTableViewController)?.restoranlarListesi = restoranlarListesi ?? []
                        
                    }
                }
            case .failure(let hata) :
                print("Hata Meydana Geldi : \(hata)")
            }
        }
        
    }
    func yorumlariGetir(viewController : UIViewController, mekanId: String) {
        
        print("Yorumları Getirdin")
        self.decoder.keyDecodingStrategy = .convertFromSnakeCase
        agServis.request(.reviews(id: mekanId)) { (sonuc) in
            
            switch sonuc {
                
                
            case .success(let veri) :
                
                if let yorumlar = try? self.decoder.decode(Cevap.self, from: veri.data) {
                    print("\n\n\n*****Yorumlar : \n \(yorumlar)*********\n\n")
                    let yorumlarVC = (viewController as? YorumlarTableViewController)
                    yorumlarVC?.yorumlar = yorumlar.yorumlar
                } else {
                    print("Veri Geldi Fakat Yorumları Decode Edemedim.")
                }
                
            case .failure(let hata) :
                print("Yorumları Getirirken Hata Meydana Geldi : \(hata)")
            }
            
        }
        
        
    }
    

}



extension AppDelegate : KonumAyarlamalari , RestoranlarListesiAction, YorumlariGetirProtocol{
    func izinVerdi() {
        konumServis.izinIste()
    }
    func restoranSec(viewController: UIViewController, restoran: RestoranListViewModel) {
        detaylariGetir(viewController: viewController, mekanId: restoran.id)
    }
    
    func getir(viewController: UIViewController, mekanId: String) {
        self.yorumlariGetir(viewController: viewController, mekanId: mekanId)
    }
}
