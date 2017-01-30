//
//  CTFScheduleItem.swift
//  ImpulsivityOhmage
//
//  Created by James Kizer on 1/29/17.
//  Copyright © 2017 Foundry @ Cornell Tech. All rights reserved.
//

import Gloss
import ResearchSuiteTaskBuilder

class CTFScheduleItem: Decodable {
    
    public let type: String!
    public let identifier: String!
    public let title: String!
    public let guid: String!
    
    public let activity: JSON!
    public let resultTransforms: [CTFResultTransform]!
    
    // MARK: - Deserialization
    
    required public init?(json: JSON) {
        
        guard let type: String = "type" <~~ json,
            let identifier: String = "identifier" <~~ json,
            let title: String = "title" <~~ json,
            let guid: String = "guid" <~~ json,
            let activity: JSON = "activity" <~~ json,
            let resultTransforms: [CTFResultTransform] = "resultTransforms" <~~ json else {
                return nil
        }
        self.type = type
        self.identifier = identifier
        self.title = title
        self.guid = guid
        
        self.activity = activity
        self.resultTransforms = resultTransforms
        
    }

}
