//
//  RestarauntLocationViewController.swift
//  MyRestarauntsApp
//
//  Created by Alexandr Zhuk on 2/22/16.
//  Copyright © 2016 Alexandr Zhuk. All rights reserved.
//

import UIKit
import MapKit

class RestarauntLocationViewController: UIViewController, MKMapViewDelegate {

    @IBOutlet weak var mapView: MKMapView!
    
    var restaraunt: Restaraunt!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.mapView.delegate = self

        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(restaraunt.location) { (placemarks, error) -> Void in
            
            if error != nil {
                print(error)
                return
            }
            
            if placemarks != nil && placemarks?.count > 0 {
                
                let placemark = placemarks![0] as CLPlacemark
                
                let annotation = MKPointAnnotation()
                annotation.title = self.restaraunt.name
                annotation.subtitle = self.restaraunt.type
                annotation.coordinate = (placemark.location?.coordinate)!
                
                self.mapView.showAnnotations([annotation], animated: true)
                self.mapView.selectAnnotation(annotation, animated: true)
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        
        let identifier = "currentPin"
        
        if annotation.isKindOfClass(MKUserLocation) {
            return nil
        }
        
        var annotationView = mapView.dequeueReusableAnnotationViewWithIdentifier(identifier)
        if annotationView == nil {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView?.canShowCallout = true
        }
        
        let leftSideAnnotationView = UIImageView(frame: CGRectMake(0, 0, 50, 50))
        leftSideAnnotationView.image = UIImage(data: restaraunt.image)
        
        annotationView?.leftCalloutAccessoryView = leftSideAnnotationView
        
        return annotationView
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
