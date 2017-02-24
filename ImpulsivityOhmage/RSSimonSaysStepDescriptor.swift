//
//  RSSimonSaysStepDescriptor.swift
//  ImpulsivityOhmage
//
//  Created by James Kizer on 2/23/17.
//  Copyright © 2017 Foundry @ Cornell Tech. All rights reserved.
//

import UIKit
import Gloss
import ResearchSuiteTaskBuilder

class RSSimonSaysStepDescriptor: RSTBStepDescriptor {
    let difficulty:Int
    
    required public init?(json: JSON) {
        
        guard let difficulty: Int = "difficulty" <~~ json else {
            return nil
        }
        
        self.difficulty = difficulty
        
        super.init(json: json)
        
        
    }
}
