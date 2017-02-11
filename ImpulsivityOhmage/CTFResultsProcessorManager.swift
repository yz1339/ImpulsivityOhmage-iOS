//
//  CTFResultsProcessorManager.swift
//  ImpulsivityOhmage
//
//  Created by James Kizer on 2/10/17.
//  Copyright © 2017 Foundry @ Cornell Tech. All rights reserved.
//

import UIKit
import ResearchSuiteResultsProcessor
import OhmageOMHSDK
import sdlrkx

class CTFResultsProcessorManager: NSObject {
    
    static let sharedInstance = CTFResultsProcessorManager()
    static let sharedResultsProcessor = sharedInstance.rsrp
    
    let rsrp: RSRPResultsProcessor
    
    private override init() {
        
        self.rsrp = RSRPResultsProcessor(
            frontEndTransformers: [
                DemographicsResultTransformer.self,
                CTFDelayDiscountingRawResultsTransformer.self,
                
                
                CTFBARTSummaryResultsTransformer.self,
                CTFGoNoGoSummaryResultsTransformer.self
            ], backEnd: ORBEManager())
        
        super.init()
        
        
    }

}
