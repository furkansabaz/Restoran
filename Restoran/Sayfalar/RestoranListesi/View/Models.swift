//
//  Models.swift
//  Restoran
//
//  Created by Furkan Sabaz on 7.06.2019.
//  Copyright © 2019 Furkan Sabaz. All rights reserved.
//

import Foundation
import CoreLocation

struct business : Codable {
    let id : String
    let name : String
    let imageUrl : URL
    let distance : Double
}

struct TumVeri : Codable {
    let businesses : [business]
}


struct RestoranListViewModel {
    let id : String
    let isYeriAdi : String
    let gorunUrl : URL
    let uzaklik : String
    
    init(yer : business) {
        
        self.isYeriAdi = yer.name
        self.id = yer.id
        self.gorunUrl = yer.imageUrl
        self.uzaklik = "\(String(format: "%.2f", (yer.distance/1000)))"
    }
    
}


struct Details : Decodable  {
    let price : String
    let phone : String
    let rating : Double
    let name : String
    let isClosed : Bool
    let photos : [URL]
    let coordinates : CLLocationCoordinate2D
}


extension CLLocationCoordinate2D : Decodable {
    enum Keys : CodingKey {
        case latitude
        case longitude
    }
    
    public init(from decoder: Decoder) throws {
        let cont = try decoder.container(keyedBy: Keys.self)
        let lat = try cont.decode(Double.self, forKey: .latitude)
        let long = try cont.decode(Double.self, forKey: .longitude)
        self.init(latitude: lat, longitude: long)
    }
}
