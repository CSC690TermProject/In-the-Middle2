//
//  ViewController.swift
//  InTheMiddle2
//
//  Created by Justin Abarquez on 4/12/18.
//  Copyright © 2018 Justin Abarquez. All rights reserved.
//

import UIKit
import GoogleMaps

class ViewController: UIViewController, UISearchBarDelegate{

    @IBOutlet weak var googleMapsContainer: UIView!
    
    var googleMapsView: GMSMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //map properties
        let camera = GMSCameraPosition.camera(withLatitude: 37.7749, longitude: -122.478, zoom: 10.25)
        let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        view = mapView
        
        //DINE button
        let dine = UIButton(frame: CGRect(x: 250, y: 550, width: 100, height: 50))
        dine.backgroundColor = .black
        dine.setTitle("DINE", for: .normal)
        dine.addTarget(self, action:#selector(self.dinePressed), for: .touchUpInside)
        self.view.addSubview(dine)

        //bar properties
        navigationItem.title = "DINE in the MIDDLE"
        self.navigationController?.navigationBar.barStyle  = UIBarStyle.black
        self.navigationController?.navigationBar.barTintColor   = UIColor(red: 153/255, green: 204/255, blue: 0/255, alpha: 1.0)
        self.navigationController?.view.backgroundColor = .clear
        self.navigationController?.navigationBar.isTranslucent = true
        let navigationTitleFont = UIFont(name: "Avenir", size: 22)!
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.font: navigationTitleFont]
    }
    
    @objc func dinePressed() {
        print("yay u did it")
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

