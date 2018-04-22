//
//  ViewController.swift
//  InTheMiddle2
//
//  Created by Justin Abarquez on 4/12/18.
//  Copyright © 2018 Justin Abarquez. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces

enum Location {
    case locationA
    case locationB
}

class ViewController: UIViewController, GMSMapViewDelegate, CLLocationManagerDelegate{

    @IBOutlet weak var googleMapsContainer: UIView!
//    @IBOutlet weak var locationA: UITextField!
//    @IBOutlet weak var locationB: UITextField!
    
    var locationA : UITextField?
    var locationB : UITextField?
    
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

        //map initialization
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
        self.locationA = UITextField(frame: CGRect(x: 20, y: 490, width: 300, height: 40))
        locationA?.placeholder = "A"
        locationA?.font = UIFont(name: "Avenir-Book", size: 25)
        locationA?.borderStyle = UITextBorderStyle.roundedRect
        locationA?.addTarget(self, action:#selector(self.openLocationA(_:)), for: .touchUpInside)
        self.view.addSubview(locationA!)
        
        self.locationB = UITextField(frame: CGRect(x: 20, y: 545, width: 300, height: 40))
        locationB?.placeholder = "B"
        locationB?.font = UIFont(name: "Avenir-Book", size: 25)
        locationB?.borderStyle = UITextBorderStyle.roundedRect
        self.view.addSubview(locationB!)
        
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
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations.last
        
        let locationSFSU = CLLocation(latitude: 37.722185, longitude: -122.478198)
        
        createMarker(titleMarker: "San Francisco State University", iconMarker: UIImage(named: "marker_gray")!, latitude: locationSFSU.coordinate.latitude, longitude: locationSFSU.coordinate.longitude)
        createMarker(titleMarker: "Berkeley", iconMarker: UIImage(named: "marker_gray")!, latitude: (location?.coordinate.latitude)!, longitude: (location?.coordinate.longitude)!)
        
//        self.googleMaps?.animate(to: camera)
        self.locationManager.stopUpdatingLocation()
        
        //        let locationB = CLLocationCoordinate2DMake(37.6879, -122.4702)
        //        let markerB = GMSMarker(position: locationB)
        //        markerB.title = "Berkeley"
        //        markerB.map = mapView
    }
    
    //GMSMapViewDelegate
    func mapView(_ mapView: GMSMapView, idleAt position: GMSCameraPosition) {
        googleMapsView.isMyLocationEnabled = true
    }
    
    func mapView(_ mapView: GMSMapView, willMove gesture: Bool) {
        googleMapsView.isMyLocationEnabled = true
        
        if (gesture) {
            mapView.selectedMarker = nil
        }
    }
    
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        googleMapsView.isMyLocationEnabled = true
        return false
    }
    
    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
        print("Coordinate: \(coordinate)") //everytime you tap on the map, it will print its coordinate
    }
    
    func didTapMyLocationButton(for mapView: GMSMapView) -> Bool {
        googleMapsView.isMyLocationEnabled = true
        googleMapsView.selectedMarker = nil
        return false
    }
    
    @IBAction func openLocationA(_ sender: UIButton) {
        let autocompleteController = GMSAutocompleteViewController()
        autocompleteController.delegate = self
        
        locationSelected = .locationA
        
        self.locationManager.stopUpdatingLocation()
        
        self.present(autocompleteController, animated: true, completion: nil)
    }
    
    @IBAction func openLocationB(_ sender: UIButton) {
        let autocompleteController = GMSAutocompleteViewController()
        autocompleteController.delegate = self
        
        locationSelected = .locationB
        
        self.locationManager.stopUpdatingLocation()
        self.present(autocompleteController, animated: true, completion: nil)
    }
    
//    @IBAction func dineButtonPressed(_ sender: UIButton) {
//        self.calculateMiddlePoint()
//    }
    
//    func calculateMiddlePoint(startLocation: CLLocation, endLocation: CLLocation) -> CLLocation {
//
//    }
    
    
    @objc func dinePressed() {
        print("yay u did it")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

//GMSAutocompleteDelegate, for autocomplete location search
extension ViewController: GMSAutocompleteViewControllerDelegate {
    
    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        print("Error: \(error)")
    }
    
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        //change map location
        let camera = GMSCameraPosition.camera(withLatitude: place.coordinate.latitude, longitude: place.coordinate.longitude, zoom: 10.25)
        
        if locationSelected == .locationA {
            locationA?.text = "\(place.coordinate.latitude), \(place.coordinate.longitude)"
            locationStart = CLLocation(latitude: place.coordinate.latitude, longitude: place.coordinate.longitude)
            //createLocationMarker()
        } else {
            locationB?.text = "\(place.coordinate.latitude), \(place.coordinate.longitude)"
            locationEnd = CLLocation(latitude: place.coordinate.latitude, longitude: place.coordinate.longitude)
            //createLocationMarker()
        }
        
        self.googleMapsView?.camera = camera
//       self.googleMapsView?.animate(to: camera)
        self.dismiss(animated: true, completion: nil)
    }
    
    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func didRequestAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
    func didUpdateAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
}

