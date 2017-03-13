//
//  RSMusicGameStepDescriptor.swift
//  ImpulsivityOhmage
//
//  Created by Yating Zhan on 3/7/17.
//  Copyright © 2017 Foundry @ Cornell Tech. All rights reserved.
//

import UIKit
import Gloss
import ResearchSuiteTaskBuilder


class RSMusicGameStepDescriptor: RSTBStepDescriptor {
    let difficulty:Int
    
    required public init?(json: JSON) {
        
        guard let difficulty: Int = "difficulty" <~~ json else {
            return nil
        }
        
        self.difficulty = difficulty
        
        super.init(json: json)
    }

}
