//
//  CTFElementListWithBindingDescriptor.swift
//  ImpulsivityOhmage
//
//  Created by James Kizer on 2/12/17.
//  Copyright © 2017 Foundry @ Cornell Tech. All rights reserved.
//

import UIKit
import Gloss
import ResearchSuiteTaskBuilder

open class CTFBindingDefinition: Decodable {
    public let bindingKey: String
    public let bindingType: String
    public let bindingValue: AnyObject
    
    // MARK: - Deserialization
    
    required public init?(json: JSON) {
        guard let bindingKey: String = "binding_key" <~~ json,
            let bindingType: String = "binding_type" <~~ json,
            let bindingValue: AnyObject = "binding_value" <~~ json
            else {
                return nil
        }
        
        self.bindingKey = bindingKey
        self.bindingType = bindingType
        self.bindingValue = bindingValue
    }
}

open class CTFBindingUsage: Decodable {
    public let bindingKey: String
    public let defaultValue: AnyObject?
    
    // MARK: - Deserialization
    
    required public init?(json: JSON) {
        guard let bindingKey: String = "binding_key" <~~ json
            else {
                return nil
        }
        
        self.bindingKey = bindingKey
        self.defaultValue = "default_value" <~~ json
    }
}

open class CTFElementListWithBindingDescriptor: RSTBElementListDescriptor {
    
    public let bindings: [CTFBindingDefinition]
    
    required public init?(json: JSON) {
        
        let bindings: [JSON] = "bindings" <~~ json ?? []
        
        self.bindings = bindings.flatMap({ (json) -> CTFBindingDefinition? in
            return CTFBindingDefinition(json: json)
        })
        
        super.init(json: json)
    }

}
