//
//  AccidentController.swift
//  crashDefense
//
//  Created by Stephanie Cleland on 2/18/16.
//  Copyright © 2016 Stephanie Cleland. All rights reserved.
//

import UIKit
import MessageUI
import MapKit
import CoreLocation


class AccidentController: UIViewController, MFMessageComposeViewControllerDelegate, CLLocationManagerDelegate{
    @IBOutlet weak var noView: UIView!
   
    @IBOutlet weak var turtle: UIButton!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var yesView: UIView!
    var backgroundTaskIdentifier: UIBackgroundTaskIdentifier?
    @IBOutlet weak var callLabel: UILabel!
    @IBOutlet weak var Logo2: UILabel!
    @IBOutlet weak var Logo: UILabel!
    @IBOutlet weak var noButton: UIButton!
    @IBOutlet weak var yesButton: UIButton!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var detectedLabel: UILabel!
    var parents_called:Bool = false
    var timer = NSTimer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBarHidden = true


        self.navigationItem.setHidesBackButton(true, animated:true)
        callLabel.hidden = true
        callLabel.text = " "
        
        noView.layer.cornerRadius = 5;
        yesView.layer.cornerRadius = 5;

        backButton.setBackgroundImage(UIImage(named:"back_button-640x594.png")!, forState: .Normal)
        backButton.setTitle("", forState: .Normal)

        
        callLabel.font = UIFont(name: "Avenir-MediumOblique", size: 17)
            questionLabel.font = UIFont(name: "Avenir-MediumOblique", size: 19)
            detectedLabel.font = UIFont(name: "Avenir-Heavy", size: 20)
            yesButton.titleLabel!.font = UIFont(name: "Helvetica-BoldOblique", size: 18)
            noButton.titleLabel!.font = UIFont(name: "Helvetica-BoldOblique", size: 18)
        
        Logo.font = UIFont(name: "Avenir-MediumOblique", size: 24)
        Logo2.font = UIFont(name: "Avenir-Heavy", size: 24)
        self.view.backgroundColor = UIColor(patternImage: UIImage(named:"846.jpg")!)
        turtle.setBackgroundImage(UIImage(named:"turtle1.png")!, forState: .Normal)
        turtle.setTitle("", forState: .Normal)
        
        backgroundTaskIdentifier = UIApplication.sharedApplication().beginBackgroundTaskWithExpirationHandler({
            UIApplication.sharedApplication().endBackgroundTask(self.backgroundTaskIdentifier!)
        })
        
        // call parents after 30 seconds of no response
        timer = NSTimer.scheduledTimerWithTimeInterval(30, target: self, selector: "call_parent", userInfo: nil, repeats: false)
        
    }

    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        _ = segue.destinationViewController as? ViewController
        timer.invalidate()
        
    }
    
    func call_parent() -> Void {
        
        timer.invalidate()
        callLabel.text = "Notifying Parents"
        callLabel.hidden = false
        parents_called = true
        yesButton.hidden = true
        noButton.hidden = true
        yesView.hidden = true
        noView.hidden = true
        
        // crashes program in simulator, because you cant sent messages
        sendcrashtext()
        
        var _ = NSTimer.scheduledTimerWithTimeInterval(5, target: self, selector: "return_to_root", userInfo: nil, repeats: false)
        
        
    }
    
    func messageComposeViewController(controller: MFMessageComposeViewController, didFinishWithResult result: MessageComposeResult) {
        controller.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    func sendcrashtext() {

        let composeVC = MFMessageComposeViewController()
        composeVC.messageComposeDelegate = self
        composeVC.recipients = [emergencyContactNum]
        let date = NSDate()
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateStyle = NSDateFormatterStyle.FullStyle
        //let stringDate = dateFormatter.stringFromDate(date)
        dateFormatter.timeStyle = NSDateFormatterStyle.ShortStyle
        let timeString = dateFormatter.stringFromDate(date)
        
        
        composeVC.body = "Hi " + emergencyContactName + ", " + childName + " got in an accident on " + timeString + /*" on " + stringDate + */" in " + myLoc + "."
        self.presentViewController(composeVC, animated: true, completion: nil)

    }

    
    func return_to_root() -> Void {
        
        performSegueWithIdentifier("backToRoot", sender: self)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func status_button_pressed(sender: UIButton) -> Void {
        let title:String = sender.currentTitle!
        
        if title == "Yes" {
            
            print("Ok, no one will be notified, but GPS position is logged")
            // go back to root controller
            
            performSegueWithIdentifier("backToRoot", sender: self)
            
        } else if title == "No" {
            
            call_parent()
            

            
        }

        
    }

}
