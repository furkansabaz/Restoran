//
//  AppDelegate.swift
//  Restoran
//
//  Created by Furkan Sabaz on 5.06.2019.
//  Copyright © 2019 Furkan Sabaz. All rights reserved.
//

import UIKit
import Moya
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    //var window: UIWindow?
    
    let window = UIWindow()
    let konumServis = KonumServis()
    let storyBoard = UIStoryboard(name: "Main", bundle: nil)
    
    let decoder = JSONDecoder()
    
    let agServis = MoyaProvider<YelpServis.VeriSaglayici>()
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        agServis.request(.search(lat: 41.01, long: 28.97)) { (sonuc) in
            switch sonuc {
            case .success(let gelenVeri) :
                
                
                self.decoder.keyDecodingStrategy = .convertFromSnakeCase
                let veri = try? self.decoder.decode(TumVeri.self, from: gelenVeri.data)
                print(veri)
                
                
            case .failure(let hata) :
                print("Hata Meydana Geldi : \(hata)")
            }
        }
        
        
        
        switch konumServis.durum {
            
        case .denied, .notDetermined, .restricted  :
            let konumVC = storyBoard.instantiateViewController(withIdentifier: "KonumViewController") as? KonumViewController
            konumVC?.konumServis = konumServis
            window.rootViewController = konumVC
            default :
            assertionFailure()
            }
        window.makeKeyAndVisible()
        
        return true
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

