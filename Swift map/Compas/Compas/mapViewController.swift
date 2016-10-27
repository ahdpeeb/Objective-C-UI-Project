//
//  ViewController.swift
//  Compas
//
//  Created by Nikola Andriiev on 25.10.16.
//  Copyright © 2016 Andriiev.Mykola. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

extension mapViewController {
    public var rootView: ANSRootView! {
        get {
            if self.isViewLoaded && self.view.isMember(of: ANSRootView.self) {
                return self.view as! ANSRootView
            }
            
            return nil
        }
    }
}

class mapViewController: UIViewController {
    
// MARK: Properties / accsessors
    private var locationManager: CLLocationManager! {
        didSet {
            locationManager.requestAlwaysAuthorization()
            locationManager.distanceFilter = 5 //meters
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
    
            locationManager.delegate = self
        }
    }
    
    private var annotationPoint:MKPointAnnotation! {
        didSet {
            if (oldValue != nil) {
                rootView.mapView.removeAnnotation(oldValue)
            }
            
            rootView.mapView.addAnnotation(annotationPoint)
        }
    }

// MARK: initialization and deallocation
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.locationManager = CLLocationManager.init()   //doesnt call
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.locationManager = CLLocationManager.init() //doesnt call
    }
    
// MARK: View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.locationManager = CLLocationManager.init()
        self.locationManager.startUpdatingLocation()
        self.locationManager.startUpdatingHeading()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
// MARK: Private methods
     func addPin(withLocation location:CLLocation) {
        let annotationPoint = MKPointAnnotation()
        annotationPoint.coordinate = location.coordinate
        annotationPoint.title = "My current location"
        self.annotationPoint = annotationPoint
    }
    
     func addresFromPlacemark(placemark: CLPlacemark) -> String {
        let country = placemark.country
        let city = placemark.locality
        let postIndex = placemark.postalCode
        let street = placemark.thoroughfare
        let streetInfo = placemark.subThoroughfare
        let fullAdress = "Country: \(country ?? "not found") \n" +
            "city: \(city ?? "not found") \n" +
            "postIndex: \(postIndex ?? "not found") \n" +
            "street: \(street ?? "not found") \n" +
        "streetInfo: \(streetInfo ?? "none")"
        
        return fullAdress
    }
}

// MARK: CLLocationManagerDelegate
extension mapViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if CLLocationManager.locationServicesEnabled() {
            guard let location: CLLocation = locations.last else {
                return
            }
            //first call//if annotationPoint == nil/ or distanсe filter
            let region = MKCoordinateRegionMakeWithDistance(location.coordinate, 500, 500);
            rootView.mapView.setRegion(region, animated: true)
            
            self.addPin(withLocation: location)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateHeading newHeading: CLHeading) {
        if CLLocationManager.headingAvailable() {
            // manage heading
        }
    }
}

// MARK: Private MKMapViewDelegate
extension mapViewController: MKMapViewDelegate {
    public func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let identifier = "identifier"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
        if annotationView == nil {
            annotationView = MKAnnotationView.init(annotation: annotation, reuseIdentifier: identifier)
        } else {
            annotationView?.annotation = annotation
        }
        
        if let annotationView = annotationView {
            //customize annotation View
            annotationView.canShowCallout = true
            //loading image in foreground!
            let imageUrl = NSURL(string: "https://cdn1.iconfinder.com/data/icons/dinosaur/154/small-dino-dinosaur-dragon-walk-48.png")
            let imageData = NSData(contentsOf: imageUrl as! URL)
            let image = UIImage(data: imageData as! Data)
            annotationView.image = image
    
            annotationView.leftCalloutAccessoryView = UIImageView(image: image)
            annotationView.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
            
            return annotationView
        }
        
        return nil
    }
    
    public func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if view.rightCalloutAccessoryView!.isEqual(control) {
            if let annotation = view.annotation {
                let coordinate = annotation.coordinate
                let location = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
                CLGeocoder().reverseGeocodeLocation(location, completionHandler: { ( placemarks : [CLPlacemark]?, error : Error?) in
                        if let placemarks = placemarks {
                            let placemark = placemarks.last
                            if let placemark = placemark {
                                self.rootView.textLaber.text = self.addresFromPlacemark(placemark: placemark)
                            }
                        }})
            }
        }
    }
    
    public func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        self.rootView.textLaber.alpha = 1;
    }
    
    public func mapView(_ mapView: MKMapView, didDeselect view: MKAnnotationView) {
       let label = self.rootView.textLaber
        if let label = label {
            label.alpha = 0;
            label.text = "";
        }
    }
    
    // MARK: END
}
