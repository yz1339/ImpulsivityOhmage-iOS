//
//  RSShootingGameStepGenerator.swift
//  ImpulsivityOhmage
//
//  Created by Yating Zhan on 3/7/17.
//  Copyright © 2017 Foundry @ Cornell Tech. All rights reserved.
//

import UIKit
import ResearchSuiteTaskBuilder
import ResearchKit
import Gloss

class RSShootingGameStepGenerator: RSTBBaseStepGenerator {
    public init(){}
    
    let _supportedTypes = [
        "RSShootingGame"
    ]
    
    public var supportedTypes: [String]! {
        return self._supportedTypes
    }
    
    open func generateStep(type: String, jsonObject: JSON, helper: RSTBTaskBuilderHelper) -> ORKStep? {
        
        guard let element = RSShootingGameStepDescriptor(json: jsonObject) else {
            return nil
        }
        
        let step = RSShootingGameStep(identifier: element.identifier)
        step.title = element.title
        step.text = element.text
        step.isOptional = element.optional
        
        return step
    }
    
    open func processStepResult(type: String,
                                jsonObject: JsonObject,
                                result: ORKStepResult,
                                helper: RSTBTaskBuilderHelper) -> JSON? {
        return nil
    }

}
