//
//  SettingsPage.swift
//  SmartRun
//
//  Created by Ahmed Jamal Yusuf on 15/02/2019.
//  Copyright © 2019 Ahmed Jamal Yusuf. All rights reserved.
//

import UIKit
import Firebase

class SettingsPage: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func signOutButton(_ sender: Any) {
        let alertController = UIAlertController(title: nil, message: "Are you sure you want to sign out?", preferredStyle: .actionSheet)
        alertController.addAction(UIAlertAction(title: "Sign Out", style: .destructive, handler: { (_) in
            self.signOut()
        }))
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
    
    func signOut() {
        do {
            try Auth.auth().signOut()
            self.performSegue(withIdentifier: "signout", sender: self)
            
        } catch let signOutError as NSError {
            print("Error signing out: ", signOutError)
        }
    }
    

}
