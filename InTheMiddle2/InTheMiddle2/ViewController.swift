//
//  ViewController.swift
//  InTheMiddle
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

class ViewController: UIViewController, GMSMapViewDelegate, CLLocationManagerDelegate {
    
    @IBOutlet weak var googleMapsView: GMSMapView!
    
    var locationA : UITextField?
    var locationB : UITextField?
    
    //create LocationManager object
    var locationManager = CLLocationManager()
    
    var locationSelected = Location.locationA
    var locationStart = CLLocationCoordinate2D()
    var locationEnd = CLLocationCoordinate2D()
    
    var locationMid = CLLocationCoordinate2D()
    var locationQuarter = CLLocationCoordinate2D()
    var locationThreeQuarter = CLLocationCoordinate2D()
    
//    var googleMapsView: GMSMapView!
    var minimalStyle: GMSMapStyle!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //set up LocationManager
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest  
        locationManager.startMonitoringSignificantLocationChanges()

        //map initialization
        let camera = GMSCameraPosition.camera(withLatitude: 37.74, longitude: -122.478, zoom: 10.25)
        minimalStyle = try! GMSMapStyle.init(contentsOfFileURL: Bundle.main.url(forResource: "modernminimal", withExtension: "json")!)
        self.googleMapsView?.mapStyle = minimalStyle
        
        self.googleMapsView?.camera = camera
        self.googleMapsView?.delegate = self
        self.view = googleMapsView
        self.googleMapsView?.isMyLocationEnabled = true
//        self.googleMapsView?.settings.myLocationButton = true
        self.googleMapsView?.settings.zoomGestures = true
        
        //FIND button properties
        let dineButton = UIButton(frame: CGRect(x: 250, y: 550, width: 112.5, height: 56.25))
        dineButton.backgroundColor = .gray
        dineButton.setTitle("FIND", for: .normal)
        dineButton.titleLabel?.font =  UIFont(name: "AvenirNextCondensed-DemiBold", size: 40)
        dineButton.titleLabel?.textColor = UIColor(red: 204/255, green: 255/255, blue: 204/255, alpha: 1.0)
        dineButton.addTarget(self, action:#selector(self.findButtonPressed), for: .touchUpInside)
        self.view.addSubview(dineButton)

        //location field properties
        self.locationA = UITextField(frame: CGRect(x: 20, y: 420, width: 300, height: 40))
        locationA?.placeholder = "Location A"
        locationA?.font = UIFont(name: "Avenir-Book", size: 25)
        locationA?.borderStyle = UITextBorderStyle.roundedRect
        locationA?.addTarget(self, action:#selector(self.openLocationA(_:)), for: .touchUpInside)
        locationA?.alpha = 0.8
        self.view.addSubview(locationA!)
        
        self.locationB = UITextField(frame: CGRect(x: 20, y: 475, width: 300, height: 40))
        locationB?.placeholder = "Location B"
        locationB?.font = UIFont(name: "Avenir-Book", size: 25)
        locationB?.borderStyle = UITextBorderStyle.roundedRect
        locationB?.addTarget(self, action:#selector(self.openLocationB(_:)), for: .touchUpInside)
        locationB?.alpha = 0.8
        self.view.addSubview(locationB!)
        
        //bar properties
        navigationItem.title = "DINE in the MIDDLE"
        self.navigationController?.navigationBar.barStyle  = UIBarStyle.black
        self.navigationController?.navigationBar.barTintColor   = UIColor(red: 166/255, green: 166/255, blue: 166/255, alpha: 1.0) //UIColor(red: 153/255, green: 204/255, blue: 0/255, alpha: 1.0)
        self.navigationController?.view.backgroundColor = .clear
        self.navigationController?.navigationBar.isTranslucent = true
        let navigationTitleFont = UIFont(name: "AvenirNextCondensed-DemiBoldItalic",  size: 27)!
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.font: navigationTitleFont]
        
        self.tabBarController?.tabBar.barTintColor = UIColor(red: 217/255, green: 217/255, blue: 217/255, alpha: 1.0)
    }

    //Location Manager delegates
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error){
        print("Error to get location: \(error)")
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        self.locationManager.stopUpdatingLocation()
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
    
    func mapView(_ mapView: GMSMapView, didTapInfoWindowOf marker: GMSMarker) {
        print("Yay u did it.")
    }
    
//    func didTapMyLocationButton(for mapView: GMSMapView) -> Bool {
//        googleMapsView.isMyLocationEnabled = true
//        googleMapsView.selectedMarker = nil
//        return false
//    }
    
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
    
    @IBAction func findButtonPressed(_ sender: UIButton) {
        //stores the coordinates at the very middle
        locationMid = GMSGeometryInterpolate(locationStart, locationEnd, 0.5)
        //stores the coordinates at the quarter mark ("Closer to You")
        locationQuarter = GMSGeometryInterpolate(locationStart, locationEnd, 0.25)
        //stores the coordinates at the three-quarter mark ("Closer to Them")
        locationThreeQuarter = GMSGeometryInterpolate(locationStart, locationEnd, 0.75)
        
        //pass midway coordinate to function that retrieves restaurant
        fetchPlacesNearCoordinate(coordinate: locationMid)
        
        //clear the map of all markers
        googleMapsView.clear()
        
        //change camera view to Midway location
        let camera = GMSCameraPosition.camera(withLatitude: locationMid.latitude, longitude: locationMid.longitude, zoom: 10.25)
        self.googleMapsView?.animate(to: camera)
        self.googleMapsView?.camera = camera
        
        //converting CLLocationCoordinate2D into CLLocation and storing the distances in miles between them (have to use another extension)
        let distanceBetweenAandMid = locationStart.distanceTo(coordinate: locationMid)
        let distanceBetweenAandQuarter = locationStart.distanceTo(coordinate: locationQuarter)
        let distanceBetweenAandThreeQuarter = locationStart.distanceTo(coordinate: locationThreeQuarter)
        
        //create a marker for the Midway point
        let markerMid = GMSMarker(position: locationMid)
        markerMid.icon = GMSMarker.markerImage(with: .green)
        markerMid.title = "Midway Point: \(distanceBetweenAandMid) miles away"
        markerMid.map = googleMapsView
        //create a marker for the Quarter point
        let markerQuarter = GMSMarker(position: locationQuarter)
        markerQuarter.icon = GMSMarker.markerImage(with: .green)
        markerQuarter.title = "Closer to Me: \(distanceBetweenAandQuarter) miles away"
        markerQuarter.map = googleMapsView
        //create a marker for the Three-Quarter point
        let markerThreeQuarter = GMSMarker(position: locationThreeQuarter)
        markerThreeQuarter.icon = GMSMarker.markerImage(with: .green)
        markerThreeQuarter.title = "Closer to Them: \(distanceBetweenAandThreeQuarter) miles away"
        markerThreeQuarter.map = googleMapsView
        
        //draw path (eventually)
        
        print("The midway point is at coordinates: \(locationMid.latitude), \(locationMid.longitude).")
    }
    
    func fetchPlacesNearCoordinate(coordinate: CLLocationCoordinate2D){
        let urlString :URLRequest = URLRequest.init(url: URL.init(string: "https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=\(coordinate.latitude),\(coordinate.longitude)&radius=8000&type=restaurant&key=AIzaSyCy4WJadzO6NS7VK2mbk10RcXT7JtvUI1o")!)
        
        print(urlString)
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        
        let placesTask = URLSession.shared.dataTask(with: urlString) {data, response, err in guard let data = data, err == nil else {
            print("error ==>\(err)")
            return
            }
            
            let responsestring = String(data: data, encoding: .utf8)
            
            do {
                let jsondata1 = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as! NSDictionary
                print("Final data Convert to JSON =>\(jsondata1)")
                
                let results = jsondata1["results"] as! NSArray
                print("Results ==> \(results)")
            }
            catch{
                print("error ==>\(err)")
            }
        }
        placesTask.resume()
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
        //change camera position
        let camera = GMSCameraPosition.camera(withLatitude: place.coordinate.latitude, longitude: place.coordinate.longitude, zoom: 10.25)
        
        if locationSelected == .locationA {
            locationA?.text =  "\(place.name)" //"\(place.coordinate.latitude), \(place.coordinate.longitude)"
            locationStart = CLLocationCoordinate2D(latitude: place.coordinate.latitude, longitude: place.coordinate.longitude)
            
            //create a marker for Location A
            let marker = GMSMarker(position: locationStart)
            marker.title = "Location A"
            marker.icon = GMSMarker.markerImage(with: .gray)
            marker.map = googleMapsView
        } else {
            locationB?.text = "\(place.name)" //"\(place.coordinate.latitude), \(place.coordinate.longitude)"
            locationEnd = CLLocationCoordinate2D(latitude: place.coordinate.latitude, longitude: place.coordinate.longitude)
            
            //create a marker for Location B
            let marker = GMSMarker(position: locationEnd)
            marker.title = "Location B"
            marker.icon = GMSMarker.markerImage(with: .gray)
            marker.map = googleMapsView
        }
        
        //change camera view to entered location
        self.googleMapsView?.animate(to: camera)
        self.googleMapsView?.camera = camera
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

extension CLLocationCoordinate2D {
    
    func distanceTo(coordinate: CLLocationCoordinate2D) -> CLLocationDistance {
        let thisLocation = CLLocation(latitude: self.latitude, longitude: self.longitude)
        let otherLocation = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
        
        //calculates distance in meters
        let distanceInMeters = thisLocation.distance(from: otherLocation)
        //converts to miles
        let distanceInMiles = distanceInMeters * 0.00062137
        //round to two decimal places
        return Double(round(100 * distanceInMiles)/100)
    }
}

extension ViewController: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        tableView.rowHeight = UITableViewAutomaticDimension
        
        let cell = TableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "restaurantCell")
        
        cell.labRestaurant.text = "restaurant"
        cell.labRestaurant.font = UIFont(name: "Avenir", size: 22)
        cell.labAddress.numberOfLines = 0
        cell.labRestaurant.lineBreakMode = NSLineBreakMode.byWordWrapping
        
        cell.labAddress.text = "address"
        cell.labAddress.font = UIFont(name: "Avenir", size: 17)
        cell.labAddress.contentMode = .scaleToFill
        cell.labAddress.numberOfLines = 0
        cell.labAddress.lineBreakMode = NSLineBreakMode.byWordWrapping
        cell.labAddress.widthAnchor.constraint(equalToConstant: 400.0).isActive = true
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
}

