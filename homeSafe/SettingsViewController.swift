//
//  SettingsViewController.swift
//  crashDefense
//
//  Created by Stephanie Cleland on 2/16/16.
//  Copyright © 2016 Stephanie Cleland. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    
    @IBOutlet weak var turtle: UIButton!
    @IBOutlet weak var settingsLabel: UILabel!
    @IBOutlet weak var messageView: UIView!
    @IBOutlet weak var contactButtonView: UIView!
    @IBOutlet weak var Logo: UILabel!
    @IBOutlet weak var Logo2: UILabel!
    @IBOutlet weak var homeButtonView: UIView!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var setEmContactButton: UIButton!
    @IBOutlet weak var setHomeLocButton: UIButton!
    @IBOutlet weak var personalizeMessageButton: UIButton!
    
    
    
    @IBOutlet weak var crashButton: UIButton!
    @IBOutlet weak var crashView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor(patternImage: UIImage(named:"846.jpg")!)

        backButton.setBackgroundImage(UIImage(named:"back_button-640x594.png")!, forState: .Normal)
        backButton.setTitle("", forState: .Normal)
        setEmContactButton.titleLabel!.font = UIFont(name: "Helvetica-BoldOblique", size: 18)
        setHomeLocButton.titleLabel!.font = UIFont(name: "Helvetica-BoldOblique", size: 18)
        personalizeMessageButton.titleLabel!.font = UIFont(name: "Helvetica-BoldOblique", size: 18)
        crashButton.titleLabel!.font = UIFont(name: "Helvetica-BoldOblique", size: 18)

        contactButtonView.layer.cornerRadius = 5;
        homeButtonView.layer.cornerRadius = 5;
        messageView.layer.cornerRadius = 5;
        crashView.layer.cornerRadius = 5;
        Logo.font = UIFont(name: "Avenir-MediumOblique", size: 24)
        Logo2.font = UIFont(name: "Avenir-Heavy", size: 24)
        settingsLabel.font = UIFont(name: "Avenir-MediumOblique", size: 28)
        
        turtle.setBackgroundImage(UIImage(named:"turtle1.png")!, forState: .Normal)
        turtle.setTitle("", forState: .Normal)
        //turtle.enabled=false

        
        settingsLabel.font = UIFont(name: "Avenir-HeavyOblique", size: 26)

        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
