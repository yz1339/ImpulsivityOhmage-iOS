//
//  RSShootingGameStepViewController.swift
//  ImpulsivityOhmage
//
//  Created by Yating Zhan on 3/7/17.
//  Copyright © 2017 Foundry @ Cornell Tech. All rights reserved.
//

import UIKit
import ResearchKit

class RSShootingGameStepViewController: ORKStepViewController {

    
    class TapHandler {
        let closure: ()->Void
        init(closure: @escaping ()->Void) {
            self.closure = closure
        }
        
        func handleTap() {
            self.closure()
        }
    }
    
    @IBOutlet weak var skipButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
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

}
