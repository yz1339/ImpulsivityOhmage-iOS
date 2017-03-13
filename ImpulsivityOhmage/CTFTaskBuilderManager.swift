//
//  CTFTaskBuilderManager.swift
//  ImpulsivityOhmage
//
//  Created by James Kizer on 1/29/17.
//  Copyright © 2017 Foundry @ Cornell Tech. All rights reserved.
//

import UIKit
import ResearchSuiteTaskBuilder
import sdlrkx
import ResearchKit

class CTFTaskBuilderManager: NSObject {
    
    static let randomMultipleChoice = false
    
    static let stepGeneratorServices: [RSTBStepGenerator] = [
        RSMusicGameStepGenerator(),
        RSReactionTimeGenerator(),
        RSTBInstructionStepGenerator(),
        RSTBTextFieldStepGenerator(),
        RSTBIntegerStepGenerator(),
        RSTBSingleChoiceStepGenerator(),
        
        randomMultipleChoice ? RSTBMultipleChoiceStepGenerator() : CTFMultipleChoice(),
        CTFRandomMultipleChoice(),
        
        CTFTimePickerStepGenerator(),
        RSTBFormStepGenerator(),
        RSTBBooleanStepGenerator(),
        CTFBARTStepGenerator(),
        CTFDelayDiscountingStepGenerator(),
        CTFGoNoGoStepGenerator(),
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
        CTFElementListWithBindingGenerator(),
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
    
    static func getJson(forFilename filename: String, inBundle bundle: Bundle = Bundle.main) -> JsonElement? {
        
        guard let filePath = bundle.path(forResource: filename, ofType: "json")
            else {
                assertionFailure("unable to locate file \(filename)")
                return nil
        }
        
        guard let fileContent = try? Data(contentsOf: URL(fileURLWithPath: filePath))
            else {
                assertionFailure("Unable to create NSData with content of file \(filePath)")
                return nil
        }
        
        let json = try! JSONSerialization.jsonObject(with: fileContent, options: JSONSerialization.ReadingOptions.mutableContainers)
        
        return json as JsonElement?
    }
    

}
