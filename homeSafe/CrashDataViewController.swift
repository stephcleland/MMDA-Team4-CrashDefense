//
//  CrashDataViewController.swift
//  crashDefense
//
//  Created by Stephanie Cleland on 2/21/16.
//  Copyright © 2016 Stephanie Cleland. All rights reserved.
//

import UIKit

class CrashDataViewController: UIViewController {
    @IBOutlet weak var scrollView: UIScrollView!

    @IBOutlet weak var turtle: UIButton!
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var Logo: UILabel!
    @IBOutlet weak var header: UILabel!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var Logo1: UILabel!
    
    override func viewDidLoad() {

        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(patternImage: UIImage(named:"846.jpg")!)
        Logo.font = UIFont(name: "Avenir-MediumOblique", size: 24)
        Logo1.font = UIFont(name: "Avenir-Heavy", size: 24)
        turtle.setBackgroundImage(UIImage(named:"turtle1.png")!, forState: .Normal)
        turtle.setTitle("", forState: .Normal)
        header.font = UIFont(name: "Avenir-HeavyOblique", size: 22)
        backButton.setBackgroundImage(UIImage(named:"back_button-640x594.png")!, forState: .Normal)
        backButton.setTitle("", forState: .Normal)
        textLabel.text=listOfCrashes
        textLabel.numberOfLines = 0
        
        textLabel.textAlignment = NSTextAlignment.Center;
        textLabel.font = UIFont.systemFontOfSize(14.0);
        scrollView.frame = self.view.bounds; // Instead of using auto layout
        scrollView.contentSize = CGSizeMake(400.0, 600.0)

        scrollView.addSubview(textLabel)
        


        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
