//
//  OpeningViewController.swift
//  BaroMyBuddy
//
//  Created by Amanda Nguyen on 11/29/17.
//  Copyright © 2017 Amanda Nguyen. All rights reserved.
//

import UIKit

class OpeningViewController: UIViewController {
    
    var altitude:Double = 0
    
    @IBOutlet weak var altitudeTextField: UITextField!
    
    @IBAction func submitAltitude(_ sender: UIButton) {
        altitude = Double(altitudeTextField.text!)!
        print(altitude)
        self.performSegue(withIdentifier: "segueOVC", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
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
