//
//  ViewController.swift
//  ImpulsivityOhmage
//
//  Created by James Kizer on 1/26/17.
//  Copyright © 2017 Foundry @ Cornell Tech. All rights reserved.
//

import UIKit
import OhmageOMHSDK
import ResearchSuiteTaskBuilder
import ResearchKit

class ViewController: UIViewController, ORKTaskViewControllerDelegate {

    static let LoginTaskIdentifier = "login task identifier"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if !OhmageOMHManager.shared.isSignedIn {
            
            let log = "Signing in"
            LogManager.sharedInstance.log(log)
            
            let loginStep = CTFOhmageLoginStep(identifier: "loginStepIdentifier")
            
            let task = ORKOrderedTask(identifier: ViewController.LoginTaskIdentifier, steps: [loginStep])
            let taskViewController = ORKTaskViewController(task: task, taskRun: nil)
            taskViewController.delegate = self
            present(taskViewController, animated: true, completion: nil)
            
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    //MARK: ORKTaskViewControllerDelegate
    public func taskViewController(_ taskViewController: ORKTaskViewController, didFinishWith reason: ORKTaskViewControllerFinishReason, error: Error?) {
        
        if reason == ORKTaskViewControllerFinishReason.completed {
            
            debugPrint(taskViewController.result)
            
        }
        
        taskViewController.dismiss(animated: true, completion: nil)
    }
}

