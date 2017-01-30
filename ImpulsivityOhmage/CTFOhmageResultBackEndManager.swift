//
//  CTFOhmageResultBackEndManager.swift
//  ImpulsivityOhmage
//
//  Created by James Kizer on 1/29/17.
//  Copyright © 2017 Foundry @ Cornell Tech. All rights reserved.
//

import UIKit
import OMHClient
import OhmageOMHSDK

protocol IntermediateDatapointTransformer {
    static func transform(intermediateResult: CTFIntermediateResult) -> OMHDataPoint?
}


class CTFOhmageResultBackEndManager: CTFResultBackEndManager {
    
    public func add(intermediateResult: CTFIntermediateResult) {
        //map intermediateResult onto OMH Datapoint
        guard let transformer: IntermediateDatapointTransformer.Type = {
            switch(intermediateResult.type) {
                case "GoNoGoSummary":
                return CTFOhmageGoNoGoSummaryResultsTransformer.self
            default:
                return nil
            }
            }(),
            let datapoint: OMHDataPoint = transformer.transform(intermediateResult: intermediateResult) else {
                return
        }
        
        //submit data point
        OhmageOMHManager.shared.addDatapoint(datapoint: datapoint) { (error) in
            debugPrint(error)
        }
        
    }
    
    

}
