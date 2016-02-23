//
//  MyLocation.swift
//  WhereAmI
//
//  Created by Stephanie Cleland on 2/8/16.
//  Copyright © 2016 Tufts University. All rights reserved.
//

import MapKit

class MyLocation : NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var subtitle: String?
    
    init(coordinate: CLLocationCoordinate2D, title: String, subtitle: String) {
        self.coordinate = coordinate
        self.title = title
        self.subtitle = subtitle
    }
}