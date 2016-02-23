//
//  PersonalizeMessageViewController.swift
//  crashDefense
//
//  Created by Stephanie Cleland on 2/16/16.
//  Copyright © 2016 Stephanie Cleland. All rights reserved.
//

import UIKit

class PersonalizeMessageViewController: UIViewController {

    @IBOutlet weak var nameDisplay: UILabel!
    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var enterButton1: UIButton!
    @IBOutlet weak var textField1: UITextField!
    
    @IBOutlet weak var Logo2: UILabel!
    @IBOutlet weak var Logo: UILabel!
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var turtle: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named:"846.jpg")!)
        Logo.font = UIFont(name: "Avenir-MediumOblique", size: 24)
        Logo2.font = UIFont(name: "Avenir-Heavy", size: 24)
        doneButton.titleLabel!.font = UIFont(name: "Helvetica-BoldOblique", size: 14)
        turtle.setBackgroundImage(UIImage(named:"turtle1.png")!, forState: .Normal)
        turtle.setTitle("", forState: .Normal)
        nameDisplay.text = "Name: " + childName
        headerLabel.font = UIFont(name: "Avenir-HeavyOblique", size: 22)
        
        nameDisplay.font = UIFont(name: "Avenir-MediumOblique", size: 12)
        label1.font = UIFont(name: "Avenir-MediumOblique", size: 17)
        

    }

    @IBAction func enter1Pressed(sender: AnyObject) {
        textField1.resignFirstResponder()
        childName = textField1.text
        nameDisplay.text = "Name: " + childName
        //print(childName)
    
    }
    @IBAction func textEntered1(sender: AnyObject) {
        textField1.resignFirstResponder()
        childName = textField1.text
        nameDisplay.text = "Name: " + childName
        //print(childName)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
