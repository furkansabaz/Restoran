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
    let id : String
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

struct DetaylarView {
    
    let mekanAdi  : String
    let telefonNumarasi : String
    let ucret : String
    let kapaliMi : String
    let puan : String
    let restoranGoruntuleri : [URL]
    let koordinatlari : CLLocationCoordinate2D
    let id : String
    init(detay : Details) {
        self.mekanAdi = detay.name
        self.telefonNumarasi = detay.phone
        self.ucret = detay.price
        self.kapaliMi = detay.isClosed ? "Kapalı" : "Açık"
        self.puan = "\(detay.rating)/5"
        self.restoranGoruntuleri = detay.photos
        self.koordinatlari = detay.coordinates
        self.id = detay.id
    }
    
}



struct User : Decodable {
    
    let imageUrl : URL
    let name : String
}

struct Review : Decodable {
    let rating : Double
    let text : String
    let user : User
}

struct Response : Decodable {
    let reviews : [Review]
}


struct Kullanici : Decodable {
    
    let goruntuUrl : URL
    let adi : String
    enum CodingKeys : String, CodingKey {
        case goruntuUrl = "imageUrl"
        case adi = "name"
    }
}

struct Yorum : Decodable {
    
    let yorumPuani : Double
    let yorumText : String
    let kullanici : Kullanici
    enum CodingKeys : String , CodingKey {
        case yorumPuani = "rating"
        case yorumText = "text"
        case kullanici = "user"
    }
    
}

struct Cevap : Decodable {
    let yorumlar : [Yorum]
    enum CodingKeys : String,CodingKey {
        case yorumlar = "reviews"
    }
}




