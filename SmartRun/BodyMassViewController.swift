//
//  BodyMassViewController.swift
//  SmartRun
//
//  Created by Ahmed Jamal Yusuf on 18/02/2019.
//  Copyright © 2019 Ahmed Jamal Yusuf. All rights reserved.
//

import UIKit

class BodyMassViewController: UIViewController {
    
    // Outlets
    
    
    
    
    
    // Action - Calcuate BMI
   
    @IBAction func CalculateBMIButton(_ sender: Any) {
        // Get Values
        let feet : Int = (feetText.text! as NSString).integerValue
        let inches : Int = (inchesText.text! as NSString).integerValue + (feet * 12)
        let pounds : Int = (poundsText.text! as NSString).integerValue
        
        if (inches != 0) {
            
            // Determine BMI = weight (lb) ÷ height2 (in2) × 703
            let bmi = Double(pounds) / Double((inches * inches)) * 703.0
            
            // Determine Category
            var category = "underweight"
            if (bmi > 18.5) { category = "normal weight" }
            if (bmi > 25.0) { category = "overweight" }
            if (bmi > 30.0) { category = "obese" }
            
            // Report Out
            bmiOutputText.text = "Your BMI is: " + String(bmi) + ". You are " + category + "."
            
        }
    }
    
    /* viewDidLoad */
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    /* didReceiveMemoryWarning */
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
