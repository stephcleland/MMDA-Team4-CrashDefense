//
//  ViewController.swift
//  WhereAmI
//
//  Created by Stephanie Cleland on 2/8/16.
//  Copyright © 2016 Tufts University. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import MessageUI

// variables for all view controllers
var childName: String!
var homeAnnotation = MKPointAnnotation()
var hasSetLocation = false
var hasSetName = false
var emergencyContactName: String!
var emergencyContactNum: String!
var listOfCrashes: String!
var myCoordinate: CLLocationCoordinate2D!
var myLoc: String!


class ViewController: UIViewController, CLLocationManagerDelegate, MFMessageComposeViewControllerDelegate  {
    
    // UI Stuff
    @IBOutlet weak var settingsButton: UIButton!
    @IBOutlet weak var Logo: UILabel!
    @IBOutlet weak var Logo2: UILabel!
    @IBOutlet weak var turtle: UIButton!
    
    
    // crash detection
    var backgroundTaskIdentifier: UIBackgroundTaskIdentifier?
    var timer = NSTimer()
    var x_acc: Double!
    var y_acc: Double!
    var z_acc: Double!
    
    @IBOutlet weak var setMyLocation: UIButton!
    @IBOutlet weak var mapView: MKMapView!
    var locationManager = CLLocationManager()
    let regionHome = CLCircularRegion(center:  CLLocationCoordinate2D(latitude: 37.334423, longitude: -122.041430), radius: 200, identifier: "home")
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBarHidden = true

        
        // UI stuff
        Logo.font = UIFont(name: "Avenir-MediumOblique", size: 24)
        Logo2.font = UIFont(name: "Avenir-Heavy", size: 24)
        settingsButton.setBackgroundImage(UIImage(named:"settings.png")!, forState: .Normal)
        settingsButton.setTitle("", forState: .Normal)
        self.view.backgroundColor = UIColor(patternImage: UIImage(named:"846.jpg")!)
        turtle.setBackgroundImage(UIImage(named:"turtle1.png")!, forState: .Normal)
        turtle.setTitle("", forState: .Normal)    
        
        // crash detection
        backgroundTaskIdentifier = UIApplication.sharedApplication().beginBackgroundTaskWithExpirationHandler({
            UIApplication.sharedApplication().endBackgroundTask(self.backgroundTaskIdentifier!)
        })
        
        // change this if don't want to launch every 5 seconds
        timer = NSTimer.scheduledTimerWithTimeInterval(2.0, target: self, selector: "generate_data", userInfo: nil, repeats: true)
                
        // Set initial location (Tufts University)
        let location = CLLocation(latitude: 42.407484, longitude: -71.119023)
        
        // Set region
        let regionRadius: CLLocationDistance = 1000 // in meters
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
            regionRadius * 2.0, regionRadius * 2.0)
        mapView.setRegion(coordinateRegion, animated: true)
        
        // dropping pin in home location
        let homeLoc = CLLocationCoordinate2DMake(37.334423, -122.041430)
        
        
        // Drop a pin
        homeAnnotation.title = "Home!"

        if (!hasSetLocation) {
            homeAnnotation.coordinate = homeLoc
        }
        mapView.addAnnotation(homeAnnotation)
        
        if (!hasSetName) {
            childName=""
            emergencyContactName=""
            emergencyContactNum=""
            listOfCrashes=""
            myLoc=""
            let alert = UIAlertController(title: "Set Up", message: "Be sure to go to settings to set your emergency contact information and home location!", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Okay", style: UIAlertActionStyle.Default, handler: nil))
            dispatch_async(dispatch_get_main_queue(), {
                self.presentViewController(alert, animated: true, completion: nil)
            })
            //self.presentViewController(alert, animated: true, completion: nil)
            hasSetName = true
        }
        
        // Get my location
        if (CLLocationManager.locationServicesEnabled()) {
            self.locationManager.delegate = self
            self.locationManager.requestLocation() // Ask for permission to use location services
            self.locationManager.requestAlwaysAuthorization()
            self.locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation // http://stackoverflow.com/questions/5930612/how-to-set-accuracy-and-distance-filter-when-using-mkmapview
            self.locationManager.distanceFilter = 400 // in meters
            self.locationManager.headingFilter = kCLHeadingFilterNone
            self.locationManager.startUpdatingLocation()
            self.locationManager.startMonitoringForRegion(regionHome)
            self.locationManager.requestStateForRegion(regionHome)
        }
        else {
            let alert = UIAlertController(title: "Location Service Disabled", message: "Sorry, your location could not be determined!", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Okay", style: UIAlertActionStyle.Default, handler: nil))
            //self.presentViewController(alert, animated: true, completion: nil)
        }
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let myLocation = MyLocation(coordinate: locationManager.location!.coordinate, title: "My Location", subtitle: "Here I am!")
        myCoordinate = locationManager.location!.coordinate
        reverseGeocode(myLocation.coordinate)
        mapView.setCenterCoordinate(myLocation.coordinate, animated: true) // move to my new location
        mapView.showsUserLocation=true

    }
    
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        let alert = UIAlertController(title: "Location Service Failed", message: "Sorry, your location could not be determined!", preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Okay", style: UIAlertActionStyle.Default, handler: nil))
       // self.presentViewController(alert, animated: true, completion: nil)
    }
    
    
    func locationManager(manager: CLLocationManager, monitoringDidFailForRegion region: CLRegion?, withError error: NSError) {
        print(error)
    }
    
    func locationManager(manager: CLLocationManager, didDetermineState state: CLRegionState, forRegion region: CLRegion) {
        switch state {
        case CLRegionState.Inside:
            print("inside home")
            sendhometext()
        case CLRegionState.Outside:
            print("outside home")
        case CLRegionState.Unknown:
            print("outside home")
        }
    }
    
    func messageComposeViewController(controller: MFMessageComposeViewController, didFinishWithResult result: MessageComposeResult) {
        controller.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func sendhometext(){
        let composeVC = MFMessageComposeViewController()
        composeVC.messageComposeDelegate = self
        composeVC.recipients = [emergencyContactNum]
        let date = NSDate()
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateStyle = NSDateFormatterStyle.FullStyle
        let stringDate = dateFormatter.stringFromDate(date)
        dateFormatter.timeStyle = NSDateFormatterStyle.ShortStyle
        let timeString = dateFormatter.stringFromDate(date)
        
        composeVC.body = "Hi " + emergencyContactName + ", " + childName + " got home safe at " + timeString + " on " + stringDate + "!"
        self.presentViewController(composeVC, animated: true, completion: nil)
    }


    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        _ = segue.destinationViewController as? AccidentController
        timer.invalidate()
        
    }
    
    func generate_data() -> Void {
        
        x_acc = drand48() * 6
        y_acc = drand48() * 6
        z_acc = drand48() * 6
        let tolerance:Double = 7.5
        let vector_force:Double = sqrt(pow(x_acc,2) + pow(y_acc,2) + pow(z_acc,2))
        
     //   print("Accelerometor Reading: \(vector_force)")
        
        if vector_force > tolerance {
            performSegueWithIdentifier("AccidentSegue", sender: self)
            // store location and date
            uploadCrashData()

            
        }
    }
    
    func uploadCrashData() {
        let date = NSDate()
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateStyle = NSDateFormatterStyle.FullStyle
        //let stringDate = dateFormatter.stringFromDate(date)
        dateFormatter.timeStyle = NSDateFormatterStyle.ShortStyle
        let timeString = dateFormatter.stringFromDate(date)
        let text = "Location: " + myLoc + ", Time & Date: " + timeString
        listOfCrashes = listOfCrashes + text + "\n"
        
        /*
        let bundleURL = NSBundle.mainBundle().bundleURL
        let fileURL = bundleURL.URLByAppendingPathComponent("crashdb.txt").path!
        
        if let outputStream = NSOutputStream(toFileAtPath: fileURL, append: true) {
            outputStream.open()
            outputStream.write(text, maxLength: text.characters.count)
            outputStream.close()
            print("success!")
        } else {
            print("Unable to upload to file")
        }
        */

    }
    
    func reverseGeocode(coordinate: CLLocationCoordinate2D) {


        let geoCoder = CLGeocoder()
        
            let location = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
        
        geoCoder.reverseGeocodeLocation(location, completionHandler: {(placemark, error) -> Void in
            
            if error != nil {
                print("Reverse geocoder failed with error" + error!.localizedDescription)
                return
            }
            
            if placemark!.count > 0 {
                let pm = placemark![0]
                myLoc = pm.locality
            }
            else {
                print("Problem with the data received from geocoder")
            }
        })
        
        
    }

}