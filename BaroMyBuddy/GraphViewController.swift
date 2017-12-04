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
    var graph:String = ""
    
    @IBAction func backButton(_ sender: UIButton) {
        self.performSegue(withIdentifier: "segueBackDVC", sender: self)
    }
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
        destVC.graphType = graph
        destVC.altitude = altitudeGoal
        
    }
    

}
