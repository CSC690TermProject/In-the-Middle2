//
//  ViewController.swift
//  InTheMiddle2
//
//  Created by Justin Abarquez on 4/12/18.
//  Copyright © 2018 Justin Abarquez. All rights reserved.
//

import UIKit
import GoogleMaps

enum Location {
    case locationA
    case locationB
}

class ViewController: UIViewController, GMSMapViewDelegate, CLLocationManagerDelegate {

    @IBOutlet weak var googleMapsContainer: UIView!
    
    var locationManager = CLLocationManager()
    var locationSelected = Location.locationA
    var locationStart = CLLocation()
    var locationEnd = CLLocation()
    
    var googleMapsView: GMSMapView!
    var minimalStyle: GMSMapStyle!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startMonitoringSignificantLocationChanges()

        //map properties
        let camera = GMSCameraPosition.camera(withLatitude: 37.74, longitude: -122.478, zoom: 10.25)
        let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        view = mapView
        minimalStyle = try! GMSMapStyle.init(contentsOfFileURL: Bundle.main.url(forResource: "modernminimal", withExtension: "json")!)
        mapView.mapStyle = minimalStyle
        
        self.googleMapsView?.camera = camera
        self.googleMapsView?.delegate = self
        self.googleMapsView?.isMyLocationEnabled = true
        self.googleMapsView?.settings.myLocationButton = true
        self.googleMapsView?.settings.zoomGestures = true
        
        //DINE button properties
        let dineButton = UIButton(frame: CGRect(x: 250, y: 600, width: 112.5, height: 56.25))
        dineButton.backgroundColor = .gray
        dineButton.setTitle("DINE", for: .normal)
        dineButton.titleLabel?.font =  UIFont(name: "AvenirNextCondensed-DemiBold", size: 40)
        dineButton.titleLabel?.textColor = UIColor(red: 204/255, green: 255/255, blue: 204/255, alpha: 1.0)
        dineButton.addTarget(self, action:#selector(self.dinePressed), for: .touchUpInside)
        self.view.addSubview(dineButton)

        //location field properties
        let locationATF =  UITextField(frame: CGRect(x: 20, y: 490, width: 300, height: 40))
        locationATF.placeholder = "A"
        locationATF.font = UIFont(name: "Avenir-Book", size: 25)
        locationATF.borderStyle = UITextBorderStyle.roundedRect
        self.view.addSubview(locationATF)
        
        let locationBTF =  UITextField(frame: CGRect(x: 20, y: 545, width: 300, height: 40))
        locationBTF.placeholder = "B"
        locationBTF.font = UIFont(name: "Avenir-Book", size: 25)
        locationBTF.borderStyle = UITextBorderStyle.roundedRect
        self.view.addSubview(locationBTF)
        
        //bar properties
        navigationItem.title = "DINE in the MIDDLE"
        self.navigationController?.navigationBar.barStyle  = UIBarStyle.black
        self.navigationController?.navigationBar.barTintColor   = .gray //UIColor(red: 153/255, green: 204/255, blue: 0/255, alpha: 1.0)
        self.navigationController?.view.backgroundColor = .clear
        self.navigationController?.navigationBar.isTranslucent = true
        let navigationTitleFont = UIFont(name: "AvenirNextCondensed-DemiBoldItalic",  size: 27)!
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.font: navigationTitleFont]
    }
    
    //creates a marker pin on the map
    func createMarker(titleMarker: String, iconMarker: UIImage, latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        let marker =  GMSMarker()
        marker.position = CLLocationCoordinate2DMake(latitude, longitude)
        marker.title = titleMarker
        marker.icon = iconMarker
        marker.map = googleMapsView
    }
    
    //Location Manager delegates
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error){
        print("Error to get location: \(error)")
    }
    
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        let location = locations.last
//    }
    
    @objc func dinePressed() {
        print("yay u did it")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

