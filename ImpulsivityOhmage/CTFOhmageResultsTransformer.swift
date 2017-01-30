//
//  CTFOhmageResultsGenerator.swift
//  ImpulsivityOhmage
//
//  Created by James Kizer on 1/30/17.
//  Copyright © 2017 Foundry @ Cornell Tech. All rights reserved.
//

import UIKit
import OMHClient

class CTFOhmageResultsTransformer: IntermediateDatapointTransformer {
    
    public static func transform(intermediateResult: CTFIntermediateResult) -> OMHDataPoint? {
        
        guard let ohmDatapoint = intermediateResult as? OMHDataPoint else {
            return nil
        }
        
        return ohmDatapoint
    }

}
