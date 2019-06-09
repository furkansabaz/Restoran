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
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}



extension AppDelegate : KonumAyarlamalari , RestoranlarListesiAction{
    func izinVerdi() {
        konumServis.izinIste()
    }
    func restoranSec(viewController: UIViewController, restoran: RestoranListViewModel) {
        detaylariGetir(viewController: viewController, mekanId: restoran.id)
    }
}
