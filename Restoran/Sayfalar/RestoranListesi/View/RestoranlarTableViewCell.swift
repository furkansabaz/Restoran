//
//  RestoranlarTableViewCell.swift
//  Restoran
//
//  Created by Furkan Sabaz on 6.06.2019.
//  Copyright © 2019 Furkan Sabaz. All rights reserved.
//

import UIKit
import AlamofireImage

class RestoranlarTableViewCell: UITableViewCell {

    @IBOutlet weak var imgRestoran : UIImageView!
    @IBOutlet weak var imgIsaret : UIImageView!
    @IBOutlet weak var lblRestoranAdi : UILabel!
    @IBOutlet weak var lblKonum : UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func gorunumAyarla(restoran : RestoranListViewModel) {
        
        imgRestoran.af_setImage(withURL: restoran.gorunUrl)
        lblRestoranAdi.text = restoran.isYeriAdi
        lblKonum.text = restoran.uzaklik
        
        
    }

}
