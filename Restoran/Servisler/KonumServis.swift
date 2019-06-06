//
//  KonumServis.swift
//  Restoran
//
//  Created by Furkan Sabaz on 6.06.2019.
//  Copyright © 2019 Furkan Sabaz. All rights reserved.
//

import Foundation
import CoreLocation


enum Sonuc<K> {
    case basarili(K)
    case hatali(Error)
}



final class KonumServis : NSObject {
    
    private let manager : CLLocationManager
    
    init(manager : CLLocationManager = .init()) {
        self.manager = manager
        super.init()
        self.manager.delegate = self
    }
    
    
    var yeniKonum : ((Sonuc<CLLocation>) -> Void)?
    var konumDegisikligi : ((Bool) -> Void)?
    
    var durum : CLAuthorizationStatus {
        return CLLocationManager.authorizationStatus()
    }
    
}


extension KonumServis : CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        
        yeniKonum?(.hatali(error))
        
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        
        if let konum = locations.sorted(by: { $0.timestamp > $1.timestamp }).first {
            yeniKonum?(.basarili(konum))
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
        switch status {
        case .denied , .notDetermined , .restricted :
            konumDegisikligi?(false)
            break
            
        default :
            konumDegisikligi?(true)
            
        }
        
    }
    
}