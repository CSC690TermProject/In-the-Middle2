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
    var minimalStyle: GMSMapStyle!

    
    override func viewDidLoad() {
        super.viewDidLoad()

        //map properties
        let camera = GMSCameraPosition.camera(withLatitude: 37.74, longitude: -122.478, zoom: 10.25)
        let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        view = mapView
        minimalStyle = try! GMSMapStyle.init(contentsOfFileURL: Bundle.main.url(forResource: "modernminimal", withExtension: "json")!)
        mapView.mapStyle = minimalStyle
        
        //DINE button properties
        let dine = UIButton(frame: CGRect(x: 235, y: 550, width: 150, height: 75))
        dine.backgroundColor = .gray
        dine.setTitle("DINE", for: .normal)
        dine.titleLabel?.font =  UIFont(name: "AvenirNextCondensed-DemiBold", size: 50)
        dine.titleLabel?.textColor = UIColor(red: 204/255, green: 255/255, blue: 204/255, alpha: 1.0)
        dine.addTarget(self, action:#selector(self.dinePressed), for: .touchUpInside)
        self.view.addSubview(dine)

        //location field properties
        let locationA =  UITextField(frame: CGRect(x: 20, y: 425, width: 350, height: 40))
        locationA.placeholder = "A"
        locationA.font = UIFont(name: "Avenir-Book", size: 25)
        locationA.borderStyle = UITextBorderStyle.roundedRect
        self.view.addSubview(locationA)
        
        let locationB =  UITextField(frame: CGRect(x: 20, y: 485, width: 350, height: 40))
        locationB.placeholder = "B"
        locationB.font = UIFont(name: "Avenir-Book", size: 25)
        locationB.borderStyle = UITextBorderStyle.roundedRect
        self.view.addSubview(locationB)
        
        //bar properties
        navigationItem.title = "DINE in the MIDDLE"
        self.navigationController?.navigationBar.barStyle  = UIBarStyle.black
        self.navigationController?.navigationBar.barTintColor   = .gray //UIColor(red: 153/255, green: 204/255, blue: 0/255, alpha: 1.0)
        self.navigationController?.view.backgroundColor = .clear
        self.navigationController?.navigationBar.isTranslucent = true
        let navigationTitleFont = UIFont(name: "AvenirNextCondensed-DemiBoldItalic",  size: 27)!
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

