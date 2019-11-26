//
//  YemekDetaylariView.swift
//  Restoran
//
//  Created by Furkan Sabaz on 6.06.2019.
//  Copyright © 2019 Furkan Sabaz. All rights reserved.
//

import Foundation
import UIKit
import MapKit

@IBDesignable class YemekDetaylariView : TemelView {
    
    @IBOutlet weak var collectionView : UICollectionView!
    @IBOutlet weak var pageControl : UIPageControl!
    @IBOutlet weak var lblFiyat : UILabel!
    @IBOutlet weak var lblSaat : UILabel!
    @IBOutlet weak var lblKonum : UILabel!
    @IBOutlet weak var lblPuan : UILabel!
    @IBOutlet weak var mapView : MKMapView!
    
    
    @IBAction func handleControl(_ sender : UIPageControl) {
        
    }
}
