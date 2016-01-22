//
//  ViewController.swift
//  SampleMap
//
//  Created by yasuhiro.okada on 2016/01/22.
//  Copyright © 2016年 yasuhiro.okada. All rights reserved.
//

import UIKit
import GoogleMaps

class ViewController: UIViewController {
    
    @IBOutlet weak var mapFrame: UIView!
    
    var mapView: GMSMapView!

    var locationManager = CLLocationManager()
    var currentLocation: CLLocation?

    override func viewDidLoad() {
        super.viewDidLoad()

        let camera = GMSCameraPosition.cameraWithLatitude(-33.86,
            longitude: 151.20, zoom: 6)
        self.mapView = GMSMapView.mapWithFrame(self.mapFrame.bounds, camera: camera)
        self.mapView.myLocationEnabled = true
        self.mapFrame.addSubview(self.mapView)
        
        self.mapView.translatesAutoresizingMaskIntoConstraints = false
        let bindings = ["view": mapView]
        self.mapFrame.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[view]|",
            options:NSLayoutFormatOptions(rawValue: 0),
            metrics:nil,
            views: bindings))
        self.mapFrame.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[view]|",
            options:NSLayoutFormatOptions(rawValue: 0),
            metrics:nil,
            views: bindings))
        
        
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2DMake(-33.86, 151.20)
        marker.title = "Sydney"
        marker.snippet = "Australia"
        marker.map = mapView
        
        self.initLM()
        
        dispatch_async(dispatch_get_main_queue(), {
            //self.searchCurrentLocation()
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

extension ViewController : CLLocationManagerDelegate {
    
    func initLM() {
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.delegate = self
    }
    
    func searchCurrentLocation() {
        let status = CLLocationManager.authorizationStatus()
        switch status{
        case .Restricted, .Denied:
            NSLog("searchCurrentLocation : \(status.rawValue)")
            break
            
        case .NotDetermined:
            locationManager.requestWhenInUseAuthorization()
            
        case .AuthorizedWhenInUse, .AuthorizedAlways:
            NSLog("startUpdatingLocation")
            locationManager.startUpdatingLocation()
        }
    }
    
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        
        switch status{
        case .Restricted, .Denied:
            manager.stopUpdatingLocation()
            
        case .AuthorizedWhenInUse, .AuthorizedAlways:
            locationManager.startUpdatingLocation()
            
        default:
            NSLog("didChangeAuthorizationStatus : \(status.rawValue)")
            break
        }
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        self.locationManager.stopUpdatingLocation()
        
        if locations.count > 0{
            self.currentLocation = locations.last
            
            let camera = GMSCameraPosition.cameraWithLatitude((currentLocation?.coordinate.latitude)!,
                longitude: (currentLocation?.coordinate.longitude)!, zoom: 12)
            self.mapView.camera = camera

        }
        
    }
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        NSLog("didFailWithError : \(error)")
        
    }
}
