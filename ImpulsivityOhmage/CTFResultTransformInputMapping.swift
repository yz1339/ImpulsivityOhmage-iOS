//
//  CTFResultTransformInputMapping.swift
//  ImpulsivityOhmage
//
//  Created by James Kizer on 1/29/17.
//  Copyright © 2017 Foundry @ Cornell Tech. All rights reserved.
//

import UIKit
import Gloss

class CTFResultTransformInputMapping: Decodable {
    
    public let stepIdentifier: String!
    public let parameter: String!
    
    required public init?(json: JSON) {
        
        guard let stepIdentifier: String = "stepIdentifier" <~~ json,
            let parameter: String = "parameter" <~~ json else {
                return nil
        }
        self.stepIdentifier = stepIdentifier
        self.parameter = parameter
        
    }

}
