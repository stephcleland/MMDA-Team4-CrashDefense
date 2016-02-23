//
//  SetLocationViewController.swift
//  homeSafe
//
//  Created by Stephanie Cleland on 2/15/16.
//  Copyright © 2016 Stephanie Cleland. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class SetLocationViewController:  UIViewController, CLLocationManagerDelegate, UISearchBarDelegate, MKMapViewDelegate {
    
    @IBOutlet weak var mapView: MKMapView!

    @IBOutlet weak var searchText: UITextField!
    var matchingItems: [MKMapItem] = [MKMapItem]()

    @IBOutlet weak var Logo2: UILabel!
    @IBOutlet weak var Logo: UILabel!
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var searchBar: UISearchBar!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named:"846.jpg")!)
        Logo.font = UIFont(name: "Avenir-MediumOblique", size: 24)
        Logo2.font = UIFont(name: "Avenir-Heavy", size: 24)
        doneButton.titleLabel!.font = UIFont(name: "Helvetica-BoldOblique", size: 14)
        
        // change this to be the user's location
        // set zoom of map view
        mapView.setCenterCoordinate(myCoordinate, animated: true) // move to my new location
        mapView.showsUserLocation=true
        
        // Set region
        let regionRadius: CLLocationDistance = 1000 // in meters
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(myCoordinate,
            regionRadius * 2.0, regionRadius * 2.0)
        mapView.setRegion(coordinateRegion, animated: true)

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func textFieldReturn(sender: AnyObject) {
        sender.resignFirstResponder()
        mapView.removeAnnotations(mapView.annotations)
        self.performSearch()
    }

    
    //http://www.techotopia.com/index.php/Working_with_MapKit_Local_Search_in_iOS_8_and_Swift
    
    func performSearch() {
        
        matchingItems.removeAll()
        let request = MKLocalSearchRequest()
        request.naturalLanguageQuery = searchText.text
        request.region = mapView.region
        
        let search = MKLocalSearch(request: request)
        
        
        search.startWithCompletionHandler({(response: MKLocalSearchResponse?, error: NSError?) in
            
            if error != nil {
                print("Error occured in search: \(error!.localizedDescription)")
            } else if response!.mapItems.count == 0 {
                print("No matches found")
            } else {
                print("Matches found")
                
                for item in response!.mapItems {
                    print("Name = \(item.name)")
                    print("Phone = \(item.phoneNumber)")
                    
                    self.matchingItems.append(item as MKMapItem)
                    print("Matching items = \(self.matchingItems.count)")
                    
                    homeAnnotation.coordinate = item.placemark.coordinate
                    hasSetLocation = true
                    //homeAnnotation.title = item.name
                    self.mapView.addAnnotation(homeAnnotation)
                }
            }
        })
    }


}
