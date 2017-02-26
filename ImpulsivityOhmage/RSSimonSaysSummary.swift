 //
//  RSSimonSaysSummary.swift
//  ImpulsivityOhmage
//
//  Created by James Kizer on 2/26/17.
//  Copyright © 2017 Foundry @ Cornell Tech. All rights reserved.
//

import UIKit
import ResearchSuiteResultsProcessor

public class RSSimonSaysSummary: RSRPIntermediateResult {
    
    static public let kType = "SimonSaysSummary"
    
    public let difficulty: Int
    public let numberOfSequences: Int
    
    public let averageResponseTimeBySequence: [TimeInterval]
    
    public init?(
        uuid: UUID,
        taskIdentifier: String,
        taskRunUUID: UUID,
        result: RSSimonSaysResult
        ) {
        
        guard let difficulty = result.step?.difficulty,
            let trialResults = result.trialResults else {
                return nil
        }
        
        self.difficulty = difficulty
        self.numberOfSequences = trialResults.count
        
        self.averageResponseTimeBySequence = trialResults.map({ (trialResult) -> TimeInterval in
            
            //extract response times
            let responseTimes: [TimeInterval] = trialResult.responseSequence.map({ (response) -> TimeInterval in
                return response.reponseTime
            })
            
            debugPrint(responseTimes)
            
            //return mean, checking for divide by 0
            return responseTimes.count > 0 ? responseTimes.reduce(0.0, +) / Double(responseTimes.count) : 0.0
            
        })
        
        debugPrint(self.averageResponseTimeBySequence)
        
        super.init(
            type: DemographicsResult.kType,
            uuid: uuid,
            taskIdentifier: taskIdentifier,
            taskRunUUID: taskRunUUID
        )
        
        self.startDate = result.startDate
        self.endDate = result.endDate
    }

}
