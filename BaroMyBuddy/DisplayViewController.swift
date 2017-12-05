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
    var graphType:String = ""
    var count:Int = 0
    
    @IBOutlet weak var altitudeGoal: UILabel!
    @IBOutlet weak var altitudeLabel: UILabel!
    @IBOutlet weak var pressureLabel: UILabel!
    @IBOutlet weak var instructionLabel: UILabel!
    
    lazy var altimeter = CMAltimeter()
    
    var altitudePath = [Double]()
    var pressurePath = [Double]()
    
    @IBAction func altitudeGraph(_ sender: UIButton) {
        if altitudePath.contains(where: {$0 >= altitude}) {
            print("show altitude graph")
            self.performSegue(withIdentifier: "segueGVC", sender: self)
        }
    }
    
    @IBAction func pressureGraph(_ sender: UIButton) {
        if altitudePath.contains(where: {$0 >= altitude}) {
            print("show pressure graph")
            self.performSegue(withIdentifier: "segueGVC", sender: self)
        }
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

    func counter() {
        count = count+1
        print(count)
    }
    
    func startAltimeter() {
        
        print("Started relative altitude updates.")
        // Check if altimeter feature is available
        if (CMAltimeter.isRelativeAltitudeAvailable()) {
            
            print("Altitude is available.")
            
            // Start altimeter updates, add it to the main queue
            self.altimeter.startRelativeAltitudeUpdates(to: OperationQueue.main, withHandler: { (altitudeData:CMAltitudeData?, error:Error?) in
                

                    let altitudeMeasured = altitudeData!.relativeAltitude.floatValue    // Relative altitude in meters
                    let pressure = altitudeData!.pressure.floatValue            // Pressure in kilopascals
                    
                    // Update labels, truncate float to two decimal points
                    self.altitudeLabel.text = String(format: "%.02f", altitudeMeasured)
                    self.pressureLabel.text = String(format: "%.02f", pressure)
                    // Update pressure and altitude arrays
                    self.altitudePath.append(Double(altitudeMeasured))
                    // print(self.altitudePath)
                    self.pressurePath.append(Double(pressure))
                    // Give user instruction based on their relative altitude
                    if self.altitudePath.contains(where: {$0 >= self.altitude}) {
                        self.instructionLabel.text = "Good Work! You did it!"
                        print("Altitude Goal Reached")
                    } else {
                        self.instructionLabel.text = "Keep Going! You Got This!"
                    }
                    //print(self.altitudePath)
                    //print(self.pressurePath)
                

            })
        
    }

    func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.

        if let destVC = segue.destination as? GraphViewController {
        destVC.pressures = pressurePath
        destVC.altitudes = altitudePath
        destVC.altitudeGoal = altitude
        }
        print("In prepare)")
        
        
        if let backVC = segue.destination as? OpeningViewController {
        backVC.altitude = altitude
        }
    }

}


