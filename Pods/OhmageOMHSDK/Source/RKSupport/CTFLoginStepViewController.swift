//
//  CTFLoginStepViewController.swift
//  Pods
//
//  Created by James Kizer on 1/24/17.
//
//

import UIKit
import ResearchKit

open class CTFLoginStepViewController: ORKFormStepViewController {
    
    public typealias ActionCompletion = (Bool) -> ()
    
    public static let LoggedInResultIdentifier = "IsLoggedInResult"
    public var loggedIn: Bool?

    override open func viewDidLoad() {
        
        super.viewDidLoad()
        
        if let step = self.step as? CTFLoginStep {
            self.continueButtonTitle = step.loginButtonTitle
            self.skipButtonTitle = step.forgotPasswordButtonTitle
        }
        
    }
    
    override open var result: ORKStepResult? {
        if let parent = super.result {
            
            if let loggedIn = loggedIn {
                
                let loggedInResult = ORKBooleanQuestionResult(identifier: CTFLoginStepViewController.LoggedInResultIdentifier)
                loggedInResult.booleanAnswer = NSNumber.init(booleanLiteral: loggedIn)
                
                parent.results?.append(loggedInResult)
            }
            
            return parent
        }
        else {
            return nil
        }
    }

    
    override open func goForward() {
        
        guard let loginStep = self.step as? CTFLoginStep,
            let loginStepResult = self.result else {
            return
        }
        
        let username = (loginStepResult.result(forIdentifier: CTFLoginStep.CTFLoginStepIdentity) as? ORKTextQuestionResult)?.answer as? String
        let password = (loginStepResult.result(forIdentifier: CTFLoginStep.CTFLoginStepPassword) as? ORKTextQuestionResult)?.answer as? String
        
        switch (username, password) {
            
        case (.some(let username), .some(let password)):
            self.loginButtonAction(username: username, password: password) { moveForward in
                if moveForward {
                    DispatchQueue.main.async {
                        super.goForward()
                    }
                }
            }
            
        default:
            self.forgotPasswordButtonAction() { moveForward in
                if moveForward {
                    DispatchQueue.main.async {
                        super.goForward()
                    }
                }
            }
        }
        
    }
    
    
    open func loginButtonAction(username: String, password: String, completion: @escaping ActionCompletion) {
        
        completion(true)
    
    }
    
    open func forgotPasswordButtonAction(completion: @escaping ActionCompletion) {
        
        completion(true)
        
    }
    
    
    
    

}
