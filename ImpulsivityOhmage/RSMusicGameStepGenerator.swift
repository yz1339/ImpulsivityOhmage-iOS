//
//  RSMusicGameStepGenerator.swift
//  ImpulsivityOhmage
//
//  Created by Yating Zhan on 3/7/17.
//  Copyright © 2017 Foundry @ Cornell Tech. All rights reserved.
//

import UIKit
import ResearchSuiteTaskBuilder
import ResearchKit
import Gloss

class RSMusicGameStepGenerator: RSTBBaseStepGenerator {
    public init(){}
    
    let _supportedTypes = [
        "RSMusicGameStep"
    ]
    
    public var supportedTypes: [String]! {
        return self._supportedTypes
    }
    
    open func generateStep(type: String, jsonObject: JSON, helper: RSTBTaskBuilderHelper) -> ORKStep? {
        
        guard let element = RSMusicGameStepDescriptor(json: jsonObject) else {
            return nil
        }
//        guard let customStepDescriptor = helper.getCustomStepDescriptor(forJsonObject: jsonObject),
//            let parameters = customStepDescriptor.parameters,
//            let stepParamDescriptor = RSMusicGameStepDescriptor(json: parameters ) else {
//                return nil
//        }

        let step = RSMusicGameStep(identifier: element.identifier)
        step.title = element.title
        step.text = element.text
        step.isOptional = element.optional
//        let reactionStep = RSMusicGameStep(identifier: element.identifier)
////        reactionStep.minimumStimulusInterval = 0.2
////        reactionStep.maximumStimulusInterval = 2.0
////        //reactionStep.numberOfAttempts = 10
////        reactionStep.thresholdAcceleration = 1
////        reactionStep.timeout = 3
        
        return step
    }
    
    open func processStepResult(type: String,
                                jsonObject: JsonObject,
                                result: ORKStepResult,
                                helper: RSTBTaskBuilderHelper) -> JSON? {
        return nil
    }

}
