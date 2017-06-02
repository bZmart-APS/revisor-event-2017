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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let annotation = MKPointAnnotation()
        
        let coord = CLLocationCoordinate2D(latitude: 55.060066, longitude: 10.606315)
        
        annotation.coordinate = coord
        annotation.title = "Centrumpladsen 1, 5700 Svendborg"
        
        map.addAnnotation(annotation)
        map.setRegion(MKCoordinateRegion(center: coord, span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5)), animated: true)
        
    }
}
 
