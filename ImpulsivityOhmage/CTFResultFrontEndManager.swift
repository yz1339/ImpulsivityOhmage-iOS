//
//  CTFResultManager.swift
//  ImpulsivityOhmage
//
//  Created by James Kizer on 1/29/17.
//  Copyright © 2017 Foundry @ Cornell Tech. All rights reserved.
//

import UIKit
import ResearchKit
import sdlrkx

class CTFResultFrontEndManager: NSObject {
    
    static let sharedInstance = CTFResultFrontEndManager()
    private var backEndManager: CTFResultBackEndManager! = CTFOhmageResultBackEndManager()
    
    typealias ResultIntermediateTransform = ([String: ORKStepResult]) -> CTFIntermediateResult?
    
    private override init() {
        
    }
    
    public func processResult(taskResult: ORKTaskResult, resultTransforms: [CTFResultTransform]) {
        
        let intermediateResults = resultTransforms.flatMap { (resultTransform) -> CTFIntermediateResult? in
            
            guard let transform = CTFResultFrontEndManager.getTransform(transformType: resultTransform.transform) else {
                return nil
            }
            
            var selectedResults: [String: ORKStepResult] = [:]
            resultTransform.inputMapping.forEach({ (inputMapping) in
                
                if let result = taskResult.stepResult(forStepIdentifier: inputMapping.stepIdentifier) {
                    selectedResults[inputMapping.parameter] = result
                }
                
            })
            
            return transform(selectedResults)
        }
        
        intermediateResults.forEach { (intermediateResult) in

            self.backEndManager.add(intermediateResult: intermediateResult)
            
        }
        
    }
    
    private static func getTransform(transformType: String) -> ResultIntermediateTransform? {
        switch(transformType) {
            case "GoNoGoSummary":
            return CTFResultFrontEndManager.goNoGoTransform
            
        default:
            return nil
        }
    }
    
    private static func goNoGoTransform(parameters: [String: ORKStepResult]) -> CTFIntermediateResult? {
        
        guard let goNoGoResult = parameters["GoNoGoResult"]?.firstResult as? CTFGoNoGoResult else {
            return nil
        }
        
        var summary = CTFGoNoGoSummary(type: "GoNoGoSummary")
        summary.startDate = goNoGoResult.startDate
        summary.endDate = goNoGoResult.endDate
        
        return summary
    }
    
    

    
    
}
