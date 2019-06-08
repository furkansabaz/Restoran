//
//  YemekDetaylariCollectionViewCell.swift
//  Restoran
//
//  Created by Furkan Sabaz on 8.06.2019.
//  Copyright © 2019 Furkan Sabaz. All rights reserved.
//

import UIKit

class YemekDetaylariCollectionViewCell: UICollectionViewCell {
    
    let imgMekan = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        ayarla()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Hata Meydana Geldi")
    }
    
    
    func ayarla() {
        contentView.addSubview(imgMekan)
        imgMekan.translatesAutoresizingMaskIntoConstraints = false
        imgMekan.contentMode = .scaleToFill
        
        
        NSLayoutConstraint.activate([
            imgMekan.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imgMekan.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imgMekan.topAnchor.constraint(equalTo: contentView.topAnchor),
            imgMekan.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
            ])
        
        
        
    }
}
