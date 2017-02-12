//
//  CTFTimePickerStepGenerator.swift
//  ImpulsivityOhmage
//
//  Created by James Kizer on 2/12/17.
//  Copyright © 2017 Foundry @ Cornell Tech. All rights reserved.
//

import UIKit
import ResearchSuiteTaskBuilder
import Gloss
import ResearchKit

open class CTFTimePickerStepGenerator: RSTBTimePickerStepGenerator {
    
    override open func generateAnswerFormat(type: String, jsonObject: JSON, helper: RSTBTaskBuilderHelper) -> ORKAnswerFormat? {
        
        guard let hour: Int? = "hour" <~~ jsonObject,
            let minute: Int? = "minute" <~~ jsonObject else {
                return ORKAnswerFormat.timeOfDayAnswerFormat()
        }
        
        let defaultDateComponents = DateComponents(hour: hour, minute: minute)
        
        return ORKAnswerFormat.timeOfDayAnswerFormat(withDefaultComponents: defaultDateComponents)
    }
    
}
