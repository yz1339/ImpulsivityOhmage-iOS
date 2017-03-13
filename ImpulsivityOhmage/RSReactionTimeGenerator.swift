//
//  RSReactionTimeGenerator.swift
//  ImpulsivityOhmage
//
//  Created by Yating Zhan on 3/13/17.
//  Copyright © 2017 Foundry @ Cornell Tech. All rights reserved.
//

import UIKit
import ResearchSuiteTaskBuilder
import ResearchKit
import Gloss

class RSReactionTimeGenerator: RSTBBaseStepGenerator {
    public init(){}
    
    let _supportedTypes = [
        "RSReactionTimeStep"
    ]
    
    public var supportedTypes: [String]! {
        return self._supportedTypes
    }
    
    open func generateStep(type: String, jsonObject: JSON, helper: RSTBTaskBuilderHelper) -> ORKStep? {
        
        guard let element = RSReactionTimeDescriptor(json: jsonObject) else {
            return nil
        }

        let reactionStep = RSReactionTimeStep(identifier: element.identifier)
        reactionStep.minimumStimulusInterval = 0.2
        reactionStep.maximumStimulusInterval = 2.0
        reactionStep.numberOfAttempts = 10
        reactionStep.thresholdAcceleration = 1
        reactionStep.timeout = 3
    
        return reactionStep
    }
    
    open func processStepResult(type: String,
                                jsonObject: JsonObject,
                                result: ORKStepResult,
                                helper: RSTBTaskBuilderHelper) -> JSON? {
        return nil
    }

}
