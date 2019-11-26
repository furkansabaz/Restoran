//
//  YemekDetaylariViewController.swift
//  Restoran
//
//  Created by Furkan Sabaz on 6.06.2019.
//  Copyright © 2019 Furkan Sabaz. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class YemekDetaylariViewController: UIViewController {

    @IBOutlet weak var yemekDetaylariView : YemekDetaylariView!
    var delegate : YorumlariGetirProtocol?
    
    
    var restoranDetaylari : DetaylarView? {
        didSet {
            print("Restoran Detaylarına Veri Atandı")
            gorunumAyarla()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        yemekDetaylariView.collectionView.register(YemekDetaylariCollectionViewCell.self, forCellWithReuseIdentifier: "MekanGoruntu")
        yemekDetaylariView.collectionView.delegate = self
        yemekDetaylariView.collectionView.dataSource = self
    }
    
    func gorunumAyarla() {
        
        yemekDetaylariView.lblPuan.text = restoranDetaylari?.puan
        yemekDetaylariView.lblSaat.text = restoranDetaylari?.kapaliMi
        yemekDetaylariView.lblFiyat.text = restoranDetaylari?.ucret
        yemekDetaylariView.lblKonum.text = restoranDetaylari?.telefonNumarasi
        
        
        yemekDetaylariView.collectionView.reloadData()
        haritadaGoster()
        title = restoranDetaylari?.mekanAdi
        
    }

    
    
    func haritadaGoster() {
        
        if let koordinat = restoranDetaylari?.koordinatlari {
            
            let bolge = MKCoordinateRegion(center: koordinat, latitudinalMeters: 90, longitudinalMeters: 90)
            yemekDetaylariView.mapView.setRegion(bolge, animated: true)
            
            let isaret = MKPointAnnotation()
            isaret.coordinate = koordinat
            isaret.title = restoranDetaylari?.mekanAdi
            yemekDetaylariView.mapView.addAnnotation(isaret)
            
        }
        
        
    }
    
    
    @IBAction func btnYorumlariGosterClicked(_ sender: UIButton) {
        guard let yorumlarVC = storyboard?.instantiateViewController(withIdentifier: "YorumlarViewController") else {return}
        navigationController?.pushViewController(yorumlarVC, animated: true)
        delegate?.getir(viewController: yorumlarVC, mekanId: restoranDetaylari!.id)
    }
    

}

protocol YorumlariGetirProtocol {
    func getir(viewController : UIViewController, mekanId : String)
}


extension YemekDetaylariViewController : UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return restoranDetaylari?.restoranGoruntuleri.count ?? 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MekanGoruntu", for: indexPath) as! YemekDetaylariCollectionViewCell
        if let goruntuUrl  = restoranDetaylari?.restoranGoruntuleri[indexPath.row] {
            cell.imgMekan.af_setImage(withURL: goruntuUrl)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: collectionView.bounds.height)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        yemekDetaylariView.pageControl.currentPage = indexPath.row
    }
    
    
}
