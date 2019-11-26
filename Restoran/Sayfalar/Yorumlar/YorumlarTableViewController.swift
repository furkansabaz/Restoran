//
//  YorumlarTableViewController.swift
//  Restoran
//
//  Created by Furkan Sabaz on 10.06.2019.
//  Copyright © 2019 Furkan Sabaz. All rights reserved.
//

import UIKit

class YorumlarTableViewController: UITableViewController {

    
    var yorumlar : [Yorum]? {
        didSet {
            print("Yorumlar Atandı")
            tableView.reloadData()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

    }

   
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return yorumlar?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "YorumCell") as! YorumlarTableViewCell
        let yorum = yorumlar![indexPath.row]
        
        cell.lblAdi.text = yorum.kullanici.adi
        cell.lblPuani.text = "Puanı : \(yorum.yorumPuani) / 5"
        cell.lblMesaji.text = yorum.yorumText
        cell.imgKullanici.af_setImage(withURL: yorum.kullanici.goruntuUrl)
        return cell
       
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }

    
}
