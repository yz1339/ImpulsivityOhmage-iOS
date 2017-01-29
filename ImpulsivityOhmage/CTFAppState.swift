//
//  CTFAppState.swift
//  ImpulsivityOhmage
//
//  Created by James Kizer on 1/29/17.
//  Copyright © 2017 Foundry @ Cornell Tech. All rights reserved.
//

import UIKit
import OhmageOMHSDK

class CTFAppState: NSObject {
    
    static let kSkippedLogIn = "SkippedLogIn"
    static let kConsented = "Consented"
    
    static let sharedInstance = CTFAppState()
    
    var _skipped: Bool = false
    
    var skipped: Bool {
        get {
            
            return self._skipped
            
        }
        set(newSkipped) {
            
            let skippedNumber: NSNumber = NSNumber(booleanLiteral: newSkipped)
            OhmageCredentialStore.sharedInstance.set(value: skippedNumber, key: CTFAppState.kSkippedLogIn)
            
            self._skipped = newSkipped
            
        }
    }
    
    var _consented: Bool = false
    
    var consented: Bool {
        get {
            
            return self._consented
            
        }
        set(newConsented) {
            
            let consentedNumber: NSNumber = NSNumber(booleanLiteral: newConsented)
            OhmageCredentialStore.sharedInstance.set(value: consentedNumber, key: CTFAppState.kConsented)
            
            self._consented = newConsented
            
        }
    }
    
    
    
    
    private override init() {
        
        if let skipped = OhmageCredentialStore.sharedInstance.get(key: CTFAppState.kSkippedLogIn) as? NSNumber {
            self._skipped = skipped.boolValue
        }
        
    }
    
    //selectors
    var isSignedIn: Bool {
        return OhmageOMHManager.shared.isSignedIn
    }
    
    var isSignedInOrSkipped: Bool {
        return self.isSignedIn || self.skipped
    }
    

}
