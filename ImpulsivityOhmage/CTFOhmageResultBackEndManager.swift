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

class CTFOhmageResultBackEndManager: CTFResultBackEndManager {
    
    typealias IntermediateDatapointTransform = (CTFIntermediateResult) -> OMHDataPoint?
    
    public func add(intermediateResult: CTFIntermediateResult) {
        //map intermediateResult onto OMH Datapoint
        guard let transform: IntermediateDatapointTransform = {
            switch(intermediateResult.type) {
                case "GoNoGoSummary":
                return CTFOhmageResultBackEndManager.goNoGoSummaryTransform
            default:
                return nil
            }
            }(),
            let datapoint: OMHDataPoint = transform(intermediateResult) else {
                return
        }
        
        //submit data point
        OhmageOMHManager.shared.addDatapoint(datapoint: datapoint) { (error) in
            debugPrint(error)
        }
        
    }
    
    private static func goNoGoSummaryTransform(_ intermediateResult: CTFIntermediateResult) -> OMHDataPoint? {
        
        guard let goNoGoSummary = intermediateResult as? CTFGoNoGoSummary else {
            return nil
        }

        return goNoGoSummary
    }

}
