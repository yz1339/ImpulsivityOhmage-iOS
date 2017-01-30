//
//  CTFBARTSummaryResultsGenerator.swift
//  ImpulsivityOhmage
//
//  Created by James Kizer on 1/30/17.
//  Copyright © 2017 Foundry @ Cornell Tech. All rights reserved.
//

import UIKit
import ResearchKit
import sdlrkx

class CTFBARTSummaryResultsTransformer: ResultIntermediateTransformer {
    
    public static func transform(parameters: [String: ORKStepResult]) -> CTFIntermediateResult? {
        
        guard let bartResult = parameters["BARTResult"]?.firstResult as? CTFBARTResult else {
            return nil
        }
        
        guard let summary = CTFBARTSummary(result: bartResult) else {
            return nil
        }
        
        summary.startDate = summary.startDate
        summary.endDate = summary.endDate
        
        return summary
    }
    
    private static let supportedTypes = [
        "BARTSummary"
    ]
    
    public static func supportsType(type: String) -> Bool {
        return self.supportedTypes.contains(type)
    }
}
