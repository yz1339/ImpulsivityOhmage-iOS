//
//  CTFElementListWithBindingGenerator.swift
//  ImpulsivityOhmage
//
//  Created by James Kizer on 2/12/17.
//  Copyright © 2017 Foundry @ Cornell Tech. All rights reserved.
//

import UIKit
import Gloss
import ResearchSuiteTaskBuilder

open class CTFElementListWithBindingGenerator: RSTBBaseElementGenerator {
    
    public init(){}
    
    let _supportedTypes = [
        "elementListWithBindings"
    ]
    
    public var supportedTypes: [String]! {
        return self._supportedTypes
    }
    
    open func getKVPForBinding(binding: CTFBindingDefinition, helper: RSTBTaskBuilderHelper) -> (String, Any)? {
        switch binding.bindingType {
        case "constant":
            return (binding.bindingKey, binding.bindingValue)
        case "stored":
            guard let stateHelper = helper.stateHelper,
                let storeKey = binding.bindingValue as? String,
                let storedValue = stateHelper.valueInState(forKey: storeKey) else {
                    return nil
            }
            return (binding.bindingKey, storedValue)
            
        default:
            return nil
        }
    }
    
    open func generateBindingsMap(bindings: [CTFBindingDefinition], helper: RSTBTaskBuilderHelper) -> [String: Any] {
        
        var returnMap: [String: Any] = [:]
        bindings.forEach { (binding) in
            
            if let (key, value) = self.getKVPForBinding(binding: binding, helper: helper) {
                returnMap[key] = value
            }
            
        }
        return returnMap
    }
    
    open func bindDataToElement(element: JSON, bindings: [String: Any]) -> JSON {
        
        var returnJson: JSON = [:]
        
        element.forEach { (pair) in
            
            if let json = pair.value as? JSON {
                
                if let binding = CTFBindingUsage(json: json) {
                    
                    if let bindingValue = bindings[binding.bindingKey] {
                        returnJson[pair.key] = bindingValue
                    }
                    else {
                        returnJson[pair.key] = binding.defaultValue
                    }
                    
                }
                else {
                    returnJson[pair.key] = bindDataToElement(element: json, bindings: bindings)
                }
                
            }
            else {
                returnJson[pair.key] = pair.value
            }
            
        }
        
        return returnJson
        
        
    }

    open func generateElements(type: String, jsonObject: JSON, helper: RSTBTaskBuilderHelper) -> [JSON]? {
        
        guard let descriptor = CTFElementListWithBindingDescriptor(json: jsonObject) else {
            return nil
        }
        
        let bindingsMap = self.generateBindingsMap(bindings: descriptor.bindings, helper: helper)
        
        let elementList: [JSON] = descriptor.elementList.map { (json) -> JSON in
            return self.bindDataToElement(element: json, bindings: bindingsMap)
        }
        
        
        let shuffledElements = elementList.shuffled(shouldShuffle: descriptor.shuffled)
        
        return shuffledElements
    }
    
}
