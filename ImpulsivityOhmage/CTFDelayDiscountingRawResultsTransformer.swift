//
//  CTFDelayDiscountingRawResultsTransformer.swift
//  ImpulsivityOhmage
//
//  Created by James Kizer on 1/30/17.
//  Copyright © 2017 Foundry @ Cornell Tech. All rights reserved.
//

import sdlrkx
import ResearchKit

class CTFDelayDiscountingRawResultsTransformer: ResultIntermediateTransformer {
    
    public static func transform(parameters: [String: ORKStepResult]) -> CTFIntermediateResult? {
        
        guard let ddResult = parameters["DelayDiscountingResult"]?.firstResult as? CTFDelayDiscountingResult else {
            return nil
        }
        
        guard let summary = CTFDelayDiscountingRaw(result: ddResult) else {
            return nil
        }
        
        summary.startDate = ddResult.startDate
        summary.endDate = ddResult.endDate
        
        return summary
    }
    
    private static let supportedTypes = [
        "DelayDiscountingRaw"
    ]
    
    public static func supportsType(type: String) -> Bool {
        return self.supportedTypes.contains(type)
    }
    
}
