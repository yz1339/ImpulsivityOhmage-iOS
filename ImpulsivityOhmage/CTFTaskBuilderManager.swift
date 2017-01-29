//
//  CTFTaskBuilderManager.swift
//  ImpulsivityOhmage
//
//  Created by James Kizer on 1/29/17.
//  Copyright © 2017 Foundry @ Cornell Tech. All rights reserved.
//

import UIKit
import ResearchSuiteTaskBuilder

class CTFTaskBuilderManager: NSObject {
    
    static let stepGeneratorServices: [RSTBStepGenerator] = [
        RSTBInstructionStepGenerator(),
        RSTBTextFieldStepGenerator(),
        RSTBIntegerStepGenerator(),
        RSTBSingleChoiceStepGenerator(),
        RSTBMultipleChoiceStepGenerator(),
        RSTBTimePickerStepGenerator(),
        RSTBFormStepGenerator(),
        RSTBBooleanStepGenerator(),
        RSTBDefaultStepGenerator()
    ]
    
    static let answerFormatGeneratorServices: [RSTBAnswerFormatGenerator] = [
        RSTBTextFieldStepGenerator(),
        RSTBIntegerStepGenerator(),
        RSTBTimePickerStepGenerator(),
        RSTBSingleChoiceStepGenerator(),
        RSTBMultipleChoiceStepGenerator(),
        RSTBBooleanStepGenerator()
    ]
    
    static let elementGeneratorServices: [RSTBElementGenerator] = [
        RSTBElementListGenerator(),
        RSTBElementFileGenerator(),
        RSTBElementSelectorGenerator()
    ]
    
    static let sharedInstance = CTFTaskBuilderManager()
    static let sharedBuilder = sharedInstance.rstb
    
    let rstb: RSTBTaskBuilder
    
    private override init() {
        
        // Do any additional setup after loading the view, typically from a nib.
        self.rstb = RSTBTaskBuilder(
            stateHelper: OhmageCredentialStore.sharedInstance,
            elementGeneratorServices: CTFTaskBuilderManager.elementGeneratorServices,
            stepGeneratorServices: CTFTaskBuilderManager.stepGeneratorServices,
            answerFormatGeneratorServices: CTFTaskBuilderManager.answerFormatGeneratorServices)
        
        super.init()
        
        
    }
    

}
