//
//  YemekDetaylariViewController.swift
//  Restoran
//
//  Created by Furkan Sabaz on 6.06.2019.
//  Copyright © 2019 Furkan Sabaz. All rights reserved.
//

import UIKit

class YemekDetaylariViewController: UIViewController {

    @IBOutlet weak var yemekDetaylariView : YemekDetaylariView!
    
    var restoranDetaylari : DetaylarView? {
        didSet {
            gorunumAyarla()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    func gorunumAyarla() {
        
        yemekDetaylariView.lblPuan.text = restoranDetaylari?.puan
        yemekDetaylariView.lblSaat.text = restoranDetaylari?.kapaliMi
        yemekDetaylariView.lblFiyat.text = restoranDetaylari?.ucret
        yemekDetaylariView.lblKonum.text = restoranDetaylari?.telefonNumarasi
        
    }

    

}
