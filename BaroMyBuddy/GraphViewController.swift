//
//  GraphViewController.swift
//  BaroMyBuddy
//
//  Created by Amanda Nguyen on 11/29/17.
//  Copyright © 2017 Amanda Nguyen. All rights reserved.
//

import UIKit

class GraphViewController: UIViewController {
    
    var pressures = [Double]()
    var altitudes = [Double]()
    var altitudeGoal:Double = 0
    var maxAmp:Double = 0
    var maxP:Double = 0
    var minP:Double = 0
    var deltaP:Double = 0
    
    @IBAction func backButton(_ sender: UIButton) {
        self.performSegue(withIdentifier: "segueBackDVC", sender: self)
    }
    
    @IBOutlet weak var maxAmplitude: UILabel!
    @IBOutlet weak var maxPressure: UILabel!
    @IBOutlet weak var deltaPressure: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if altitudes.isEmpty {
            print("Altitutes did not transfer")
        } else {
            getValues()
        }
        
        // Do any additional setup after loading the view.
    }


    
    
    func getValues() {
        
        maxAmp = altitudes.max()!
        maxP = self.pressures.max()!
        minP = self.pressures.min()!
        deltaP = self.maxP - self.minP
        
        maxAmplitude.text = String(format: "%.02f", maxAmp)
        maxPressure.text = String(format: "%.02f", maxP)
        deltaPressure.text = String(format: "%.02f", deltaP)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        let destVC = segue.destination as! DisplayViewController
        destVC.pressurePath = pressures
        destVC.altitudePath = altitudes
        destVC.altitude = altitudeGoal
        
    }
    

}
