//
//  RSSimonSaysSummaryTransformer.swift
//  ImpulsivityOhmage
//
//  Created by James Kizer on 2/26/17.
//  Copyright © 2017 Foundry @ Cornell Tech. All rights reserved.
//

import UIKit
import ResearchKit
import ResearchSuiteResultsProcessor

class RSSimonSaysSummaryTransformer: RSRPFrontEndTransformer {

    private static let supportedTypes = [
        "SimonSaysSummary"
    ]
    
    public static func supportsType(type: String) -> Bool {
        return self.supportedTypes.contains(type)
    }
    
    public static func transform(
        taskIdentifier: String,
        taskRunUUID: UUID,
        parameters: [String: AnyObject]
        ) -> RSRPIntermediateResult? {
        
        guard let simonSaysResult = parameters["simonSaysStepResult"]?.firstResult as? RSSimonSaysResult,
            let summary = RSSimonSaysSummary(uuid: UUID(), taskIdentifier: taskIdentifier, taskRunUUID: taskRunUUID, result: simonSaysResult) else {
            return nil
        }
        
        return summary
        
    }
}
