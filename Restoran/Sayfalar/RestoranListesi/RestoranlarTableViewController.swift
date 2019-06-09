//
//  RestoranlarTableViewController.swift
//  Restoran
//
//  Created by Furkan Sabaz on 6.06.2019.
//  Copyright © 2019 Furkan Sabaz. All rights reserved.
//

import UIKit

protocol RestoranlarListesiAction {
    func restoranSec(viewController : UIViewController,restoran : RestoranListViewModel)
}


class RestoranlarTableViewController: UITableViewController {

    var delegate : RestoranlarListesiAction?
    
    
    var restoranlarListesi = [RestoranListViewModel]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        aramaAlaniEkle()
        
    }

    

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return restoranlarListesi.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "RestoranCell", for: indexPath) as! RestoranlarTableViewCell
        let restoran = restoranlarListesi[indexPath.row]
        
        cell.gorunumAyarla(restoran: restoran)
        
        return cell
        
    }
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 400
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let detaylarVC = storyboard?.instantiateViewController(withIdentifier: "DetaylarViewController") else {return}
        
        navigationController?.pushViewController(detaylarVC, animated: true)
        let secilenRestoran = restoranlarListesi[indexPath.row]
        delegate?.restoranSec(viewController: detaylarVC, restoran: secilenRestoran)
        
    }
    
    
    func aramaAlaniEkle() {
        navigationItem.largeTitleDisplayMode = .never
        let searchController = UISearchController(searchResultsController: nil)
        navigationItem.searchController = searchController
        
        navigationItem.hidesSearchBarWhenScrolling = false
        
        searchController.searchBar.delegate = self
    }
    
}

extension RestoranlarTableViewController : UISearchBarDelegate {
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        
        if let aramaIfade = searchBar.text {
            
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            appDelegate.aramaFiltresi = aramaIfade
        }
    }
    
}
