//
//  CTFOnboardingViewController.swift
//  ImpulsivityOhmage
//
//  Created by James Kizer on 1/29/17.
//  Copyright © 2017 Foundry @ Cornell Tech. All rights reserved.
//

import UIKit
import ResearchKit
import OhmageOMHSDK

class CTFOnboardingViewController: UIViewController, ORKTaskViewControllerDelegate {

    static let LoginTaskIdentifier = "login task identifier"
    static let LoginStepdentifier = "login step identifier"

    
    @IBOutlet weak var signInButton: UIButton!
    
    var isDismissing: Bool = false
    
    var taskFinishedHandler: ((ORKTaskViewController, ORKTaskViewControllerFinishReason, Error?) -> ())?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.updateUI()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.updateUI()
    }
    
    func updateUI() {
        if !CTFAppState.sharedInstance.isSignedIn {
            self.signInButton.setTitle("Sign In", for: .normal)
            
        }
        else {
            self.signInButton.setTitle("Consent", for: .normal)
        }
        
        
    }
    
    func showLogIn(animated: Bool) {
        let log = "Signing in"
        LogManager.sharedInstance.log(log)
        
        let loginStep = CTFOhmageLoginStep(identifier: CTFOnboardingViewController.LoginStepdentifier)
        
        let task = ORKOrderedTask(identifier: CTFOnboardingViewController.LoginTaskIdentifier, steps: [loginStep])
        let taskViewController = ORKTaskViewController(task: task, taskRun: nil)
        taskViewController.delegate = self
        
        self.taskFinishedHandler = { [weak self] (taskViewController, reason, error) in
            
            if reason == ORKTaskViewControllerFinishReason.completed {
                let taskResult = taskViewController.result
                guard let loginStepResult = taskResult.stepResult(forStepIdentifier: CTFOnboardingViewController.LoginStepdentifier),
                    let loggedInResult = loginStepResult.result(forIdentifier: CTFLoginStepViewController.LoggedInResultIdentifier) as? ORKBooleanQuestionResult,
                let booleanAnswer = loggedInResult.booleanAnswer else {
                    return
                }
                
                
                if booleanAnswer.boolValue {
                    //we are logged in
                    
//                    self.updateUI()
                    taskViewController.dismiss(animated: true, completion: {
                        
                    })
                }
                //not logged in, did we skip?? what happens if so?
                else {
                    
                    CTFAppState.sharedInstance.skipped = true
                    self?.isDismissing = true
                    taskViewController.dismiss(animated: true, completion: { 
                        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
                            _ = appDelegate.showViewController()
                        }
                    })
                    
                }
                
            }
            
        }
        
        
        present(taskViewController, animated: animated, completion: nil)
    }
    
    func showConsent(animated: Bool) {
        CTFAppState.sharedInstance.consented = true
        
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            _ = appDelegate.showViewController()
        }
    }
    
    
    func taskViewController(_ taskViewController: ORKTaskViewController, didFinishWith reason: ORKTaskViewControllerFinishReason, error: Error?) {
        
        taskFinishedHandler?(taskViewController, reason, error)
        
        
    }

    @IBAction func signInPressed(_ sender: Any) {
        
        if !CTFAppState.sharedInstance.isSignedIn {
            self.showLogIn(animated: true)
            
        }
        else {
            self.showConsent(animated: true)
        }
        
    }
    
    @IBAction func skipSignInPressed(_ sender: Any) {
        
        CTFAppState.sharedInstance.skipped = true
        self.isDismissing = true
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            _ = appDelegate.showViewController()
        }
        
    }
}
