//
//  OhmageStore.swift
//  ImpulsivityOhmage
//
//  Created by James Kizer on 1/26/17.
//  Copyright © 2017 Foundry @ Cornell Tech. All rights reserved.
//

import UIKit
import ResearchKit
import OhmageOMHSDK

class OhmageCredentialStore: OhmageOMHSDKCredentialStore {
    
    static func setKeychainObject(_ object: NSSecureCoding?, forKey key: String) {
        do {
            if let obj = object {
                try ORKKeychainWrapper.setObject(obj, forKey: key)
            }
            else {
                try ORKKeychainWrapper.removeObject(forKey: key)
            }
        } catch let error {
            assertionFailure("Got error \(error) when setting \(key)")
        }
    }
    
    static func clearKeychain() {
        do {
            try ORKKeychainWrapper.resetKeychain()
        } catch let error {
            assertionFailure("Got error \(error) when resetting keychain")
        }
    }
    
    static func getKeychainObject(_ key: String) -> NSSecureCoding? {
        
        var error: NSError?
        let o = ORKKeychainWrapper.object(forKey: key, error: &error)
        if error == nil {
            return o
        }
        else {
            print("Got error \(error) when getting \(key). This may just be the key has not yet been set!!")
            return nil
        }
    }

    
    public func set(value: NSSecureCoding?, key: String) {
        OhmageCredentialStore.setKeychainObject(value, forKey: key)
    }
    
    public func get(key: String) -> NSSecureCoding? {
        return OhmageCredentialStore.getKeychainObject(key)
    }

}
