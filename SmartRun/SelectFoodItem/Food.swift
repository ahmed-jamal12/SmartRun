//
//  Food.swift
//  SmartRun
//
//  Created by Ahmed Jamal Yusuf on 15/02/2019.
//  Copyright © 2019 Ahmed Jamal Yusuf. All rights reserved.
//

import UIKit

class Food: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.HideKeyboard()
        configureViewComponents()

        // Do any additional setup after loading the view.
    }
    

    func configureViewComponents() {
        
        
        navigationItem.title = "Healthy Foods"
        
       
    }

}
