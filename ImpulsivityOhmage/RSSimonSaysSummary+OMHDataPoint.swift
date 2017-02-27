//
//  RSSimonSaysSummary+OMHDataPoint.swift
//  ImpulsivityOhmage
//
//  Created by James Kizer on 2/26/17.
//  Copyright © 2017 Foundry @ Cornell Tech. All rights reserved.
//

import Foundation
import OMHClient

extension RSSimonSaysSummary: OMHDataPointBuilder {
    
    open var creationDateTime: Date {
        return self.startDate ?? Date()
    }
    
    open var dataPointID: String {
        return self.uuid.uuidString
    }
    
    open var acquisitionModality: OMHAcquisitionProvenanceModality? {
        return .Sensed
    }
    
    open var acquisitionSourceCreationDateTime: Date? {
        return self.startDate
    }
    
    open var acquisitionSourceName: String? {
        return Bundle.main.infoDictionary![kCFBundleNameKey as String] as? String
    }
    
    open var schema: OMHSchema {
        return OMHSchema(name: "SimonSaysSummary", version: "1.0", namespace: "Cornell")
    }
    
    open var body: [String: Any] {
        return [
            "difficulty": self.difficulty,
            "numberOfSequences": self.numberOfSequences,
            "averageResponseTimeBySequence": self.averageResponseTimeBySequence
        ]
    }
}
