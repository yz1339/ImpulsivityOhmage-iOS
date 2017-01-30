//
//  ImpulsivityConsentSample.swift
//  ImpulsivityOhmage
//
//  Created by James Kizer on 1/29/17.
//  Copyright © 2017 Foundry @ Cornell Tech. All rights reserved.
//

import OhmageOMHSDK
import OMHClient

class ImpulsivityConsentSample: ConsentSample {
    
    static let impulsivitySchema = OMHSchema(
        name: "impulsivity-consent",
        version: "1.0",
        namespace: "cornell")
    
    override open var schema: OMHSchema {
        return ImpulsivityConsentSample.impulsivitySchema
    }
    
}
