//
//  CTFResultManager.swift
//  ImpulsivityOhmage
//
//  Created by James Kizer on 1/29/17.
//  Copyright © 2017 Foundry @ Cornell Tech. All rights reserved.
//

import UIKit
import ResearchKit

protocol ResultIntermediateTransformer {
    static func transform(parameters: [String: ORKStepResult]) -> CTFIntermediateResult?
    static func supportsType(type: String) -> Bool
}

class CTFResultFrontEndManager: NSObject {
    
    static let sharedInstance = CTFResultFrontEndManager()
    private var backEndManager: CTFResultBackEndManager! = CTFOhmageResultBackEndManager()
    
    static private let transformers: [ResultIntermediateTransformer.Type] = [
        CTFGoNoGoSummaryResultsTransformer.self,
        CTFBARTSummaryResultsTransformer.self,
        CTFDelayDiscountingRawResultsTransformer.self
    ]
    
    private override init() {
        
        
        
    }
    
    public func processResult(taskResult: ORKTaskResult, resultTransforms: [CTFResultTransform]) {
        
        let intermediateResults = resultTransforms.flatMap { (resultTransform) -> CTFIntermediateResult? in
            
            var selectedResults: [String: ORKStepResult] = [:]
            resultTransform.inputMapping.forEach({ (inputMapping) in
                
                if let result = taskResult.stepResult(forStepIdentifier: inputMapping.stepIdentifier) {
                    selectedResults[inputMapping.parameter] = result
                }
                
            })
            
            return CTFResultFrontEndManager.transformResult(type: resultTransform.transform, parameters: selectedResults)
        }
        
        intermediateResults.forEach { (intermediateResult) in

            self.backEndManager.add(intermediateResult: intermediateResult)
            
        }
        
    }
    
    
    static public func transformResult(type: String, parameters: [String: ORKStepResult]) -> CTFIntermediateResult? {

        for transformer in CTFResultFrontEndManager.transformers {
            if transformer.supportsType(type: type),
                let intermediateResult = transformer.transform(parameters: parameters) {
                return intermediateResult
            }
        }
        
        return nil
        
    }
    
}
