//
//  KonumViewController.swift
//  Restoran
//
//  Created by Furkan Sabaz on 6.06.2019.
//  Copyright © 2019 Furkan Sabaz. All rights reserved.
//

import UIKit


protocol KonumAyarlamalari {
    func izinVerdi()
}
class KonumViewController: UIViewController {

    
    @IBOutlet weak var konumView : KonumView!
    var delegeate : KonumAyarlamalari?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        konumView.izinVerdi = {
            self.delegeate?.izinVerdi()
        }
        
        
        
        
        
        
        
        
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
