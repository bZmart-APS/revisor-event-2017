//
//  MapVC.swift
//  revisorevent
//
//  Created by Alexander Steen on 02/06/2017.
//  Copyright © 2017 bZmart. All rights reserved.
//

import UIKit
import MapKit

class MapVC: UIViewController {
    
    @IBOutlet weak var map: MKMapView!
    
    private var lat: CLLocationDegrees = 55.060066
    private var long: CLLocationDegrees = 10.606315
    private var name: String = "Centrumpladsen 1, 5700 Svendborg"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let annotation = MKPointAnnotation()
        
        let coord = CLLocationCoordinate2D(latitude: lat, longitude: long)
        
        annotation.coordinate = coord
        annotation.title = name
        
        map.addAnnotation(annotation)
        map.setRegion(MKCoordinateRegion(center: coord, span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5)), animated: true)
    }
    
    @IBAction func openDirc(_ sender: Any) {
        openMapForPlace(latitude: lat, longitude: long, name: name)
    }
    
    func openMapForPlace(latitude: CLLocationDegrees, longitude: CLLocationDegrees, name: String) {
        let regionDistance:CLLocationDistance = 10000
        let coordinates = CLLocationCoordinate2DMake(latitude, longitude)
        let regionSpan = MKCoordinateRegionMakeWithDistance(coordinates, regionDistance, regionDistance)
        let options = [
            MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: regionSpan.center),
            MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan: regionSpan.span)
        ]
        let placemark = MKPlacemark(coordinate: coordinates, addressDictionary: nil)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = name
        mapItem.openInMaps(launchOptions: options)
    }
}
 
