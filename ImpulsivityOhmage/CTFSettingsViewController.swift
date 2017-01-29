//
//  CTFSettingsViewController.swift
//  ImpulsivityOhmage
//
//  Created by James Kizer on 1/29/17.
//  Copyright © 2017 Foundry @ Cornell Tech. All rights reserved.
//

import UIKit
import OhmageOMHSDK

class CTFSettingsViewController: UIViewController {

    @IBOutlet weak var signOutButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func signOutPressed(_ sender: Any) {
        
        OhmageOMHManager.shared.signOut { (err) in
            if let error = err {
                fatalError("Cannot sign out")
            }
            else {
                CTFAppState.sharedInstance.skipped = false
                if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
                    _ = appDelegate.showViewController()
                }
            }
        }
        
    }
    

}
