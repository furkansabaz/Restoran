//
//  KonumView.swift
//  Restoran
//
//  Created by Furkan Sabaz on 6.06.2019.
//  Copyright © 2019 Furkan Sabaz. All rights reserved.
//

import UIKit

@IBDesignable class KonumView: TemelView {

    
    @IBOutlet weak var btnIzinVer : UIButton!
    @IBOutlet weak var btnReddet : UIButton!
    
    
    
    var izinVerdi : (() -> Void)?
    
    
    @IBAction func btnIzinVerClicked(_ sender : UIButton) {
      izinVerdi?()
    }
    
    @IBAction func btnReddetClicked(_ sender : UIButton) {
        
    }
}
