//
//  DisplayViewController.swift
//  BaroMyBuddy
//
//  Created by Amanda Nguyen on 11/29/17.
//  Copyright © 2017 Amanda Nguyen. All rights reserved.
//

import UIKit
import CoreMotion

class DisplayViewController: UIViewController {

    var altitude:Double = 0
    
    @IBOutlet weak var altitudeGoal: UILabel!
    @IBOutlet weak var altitudeLabel: UILabel!
    @IBOutlet weak var pressureLabel: UILabel!
    
    lazy var altimeter = CMAltimeter()
    
    @IBAction func altitudeGraph(_ sender: UIButton) {
        print("show altitude graph")
        self.performSegue(withIdentifier: "segueGVC", sender: self)
    }
    
    @IBAction func pressureGraph(_ sender: UIButton) {
        print("show pressure graph")
        self.performSegue(withIdentifier: "segueGVC", sender: self)
    }
    
    @IBAction func backButton(_ sender: UIButton) {
        self.performSegue(withIdentifier: "segueBackOVC", sender: self)

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        altitudeGoal.text = String(altitude)
        self.startAltimeter()
        
        // Do any additional setup after loading the view.
    }

    func startAltimeter() {
        
        print("Started relative altitude updates.")
        
        // Check if altimeter feature is available
        if (CMAltimeter.isRelativeAltitudeAvailable()) {
            
            print("Altitude is available.")
            
            // Start altimeter updates, add it to the main queue
            self.altimeter.startRelativeAltitudeUpdates(to: OperationQueue.main, withHandler: { (altitudeData:CMAltitudeData?, error:Error?) in
                
             //   if (error != nil) {
                    
                    // If there's an error, stop updating and alert the user
                    
                    //let alertView = UIAlertView(title: "Error", message: error!.localizedDescription, delegate: nil, cancelButtonTitle: "OK")
                 //   alertView.show()
                    
             //   } else {
                    
                    let altitudeMeasured = altitudeData!.relativeAltitude.floatValue    // Relative altitude in meters
                    let pressure = altitudeData!.pressure.floatValue            // Pressure in kilopascals
                    
                    // Update labels, truncate float to two decimal points
                    self.altitudeLabel.text = String(format: "%.02f", altitudeMeasured)
                    self.pressureLabel.text = String(format: "%.02f", pressure)
                    
      //          }
            })
            
     //   } else {
            
    //        let alertView = UIAlertView(title: "Error", message: "Barometer not available on this device.", delegate: nil, cancelButtonTitle: "OK")
      //      alertView.show()
            
  //      }
        
    }

    func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    }}


