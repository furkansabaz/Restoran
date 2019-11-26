//
//  YorumlarTableViewCell.swift
//  Restoran
//
//  Created by Furkan Sabaz on 10.06.2019.
//  Copyright © 2019 Furkan Sabaz. All rights reserved.
//

import UIKit

class YorumlarTableViewCell: UITableViewCell {

    @IBOutlet weak var lblMesaji: UILabel!
    @IBOutlet weak var lblPuani: UILabel!
    @IBOutlet weak var lblAdi: UILabel!
    @IBOutlet weak var imgKullanici: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
