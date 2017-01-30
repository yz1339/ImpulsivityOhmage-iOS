//
//  CTFResultTransform.swift
//  ImpulsivityOhmage
//
//  Created by James Kizer on 1/29/17.
//  Copyright © 2017 Foundry @ Cornell Tech. All rights reserved.
//

import UIKit
import Gloss



class CTFResultTransform: Decodable {
    
    public let transform: String!
    public let inputMapping: [CTFResultTransformInputMapping]!
    
    required public init?(json: JSON) {
        
        guard let transform: String = "transform" <~~ json,
            let inputMapping: [CTFResultTransformInputMapping] = "inputMapping" <~~ json else {
                return nil
        }
        self.transform = transform
        self.inputMapping = inputMapping
        
    }

}
