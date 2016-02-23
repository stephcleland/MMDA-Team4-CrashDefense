//
//  SetContactViewController.swift
//  crashDefense
//
//  Created by Stephanie Cleland on 2/16/16.
//  Copyright © 2016 Stephanie Cleland. All rights reserved.
//

import UIKit

class SetContactViewController: UIViewController {

    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var nameDisplay: UILabel!
    @IBOutlet weak var nameEnterButton: UIButton!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var numberTextField: UITextField!
    @IBOutlet weak var numberEnterButton: UIButton!
    @IBOutlet weak var numberDisplay: UILabel!
    
    @IBOutlet weak var turtle: UIButton!
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var Logo2: UILabel!
    @IBOutlet weak var Logo: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named:"846.jpg")!)
        Logo.font = UIFont(name: "Avenir-MediumOblique", size: 24)
        Logo2.font = UIFont(name: "Avenir-Heavy", size: 24)
        doneButton.titleLabel!.font = UIFont(name: "Helvetica-BoldOblique", size: 14)

        turtle.setBackgroundImage(UIImage(named:"turtle1.png")!, forState: .Normal)
        turtle.setTitle("", forState: .Normal)
        
        nameDisplay.text = "Name: " + emergencyContactName
        numberDisplay.text = "Phone #: " + emergencyContactNum
        
        headerLabel.font = UIFont(name: "Avenir-HeavyOblique", size: 22)
        
        nameDisplay.font = UIFont(name: "Avenir-MediumOblique", size: 12)
        nameLabel.font = UIFont(name: "Avenir-MediumOblique", size: 17)
        numberDisplay.font = UIFont(name: "Avenir-MediumOblique", size: 12)
        numberLabel.font = UIFont(name: "Avenir-MediumOblique", size: 17)


    }

    @IBAction func nameEnterPressed(sender: AnyObject) {
        nameTextField.resignFirstResponder()
        emergencyContactName = nameTextField.text
        nameDisplay.text = "Name: " + emergencyContactName
    }
    @IBAction func numberEnterPressed(sender: AnyObject) {
        numberTextField.resignFirstResponder()
        emergencyContactNum = numberTextField.text
        numberDisplay.text = "Phone #: " + emergencyContactNum
    }
    @IBAction func nameTextEntered(sender: AnyObject) {
        nameTextField.resignFirstResponder()
        emergencyContactName = nameTextField.text
        nameDisplay.text = "Name: " + emergencyContactName
    }
    
    @IBAction func numberTextEntered(sender: AnyObject) {
        numberTextField.resignFirstResponder()
        emergencyContactNum = numberTextField.text
        numberDisplay.text = "Phone #: " + emergencyContactNum
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
