//
//  OpeningViewController.swift
//  BaroMyBuddy
//
//  Created by Amanda Nguyen on 11/29/17.
//  Copyright © 2017 Amanda Nguyen. All rights reserved.
//

import UIKit

class OpeningViewController: UIViewController, UITextFieldDelegate {
    
    var altitude:Double = 0
    
    @IBOutlet weak var altitudeTextField: UITextField!
    
    @IBAction func submitAltitude(_ sender: UIButton) {
        
        //userInput = altitudeTextField.text
        
        if altitudeTextField.text != "" {
        altitude = Double(altitudeTextField.text!)!
        }
        print(altitude)
        self.performSegue(withIdentifier: "segueOVC", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        altitudeTextField.delegate = self
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func textFieldShouldReturn(_ altitudeTextField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
        
    override func prepare(for segue:UIStoryboardSegue, sender:Any?) {
        if let destVC = segue.destination as? DisplayViewController {
            destVC.altitude = altitude
        }
    }
}
