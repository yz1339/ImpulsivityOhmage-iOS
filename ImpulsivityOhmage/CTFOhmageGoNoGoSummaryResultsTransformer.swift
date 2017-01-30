//
//  CTFOhmageGoNoGoSummaryResultsGenerator.swift
//  ImpulsivityOhmage
//
//  Created by James Kizer on 1/30/17.
//  Copyright © 2017 Foundry @ Cornell Tech. All rights reserved.
//

import UIKit
import OMHClient

class CTFOhmageGoNoGoSummaryResultsTransformer: IntermediateDatapointTransformer {
    
    public static func transform(intermediateResult: CTFIntermediateResult) -> OMHDataPoint? {
        
        guard let goNoGoSummary = intermediateResult as? CTFGoNoGoSummary else {
            return nil
        }
        
        return goNoGoSummary
    }

}
