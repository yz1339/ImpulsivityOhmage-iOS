//
//  CTFAppConfigPage.swift
//  ImpulsivityOhmage
//
//  Created by James Kizer on 2/11/17.
//  Copyright © 2017 Foundry @ Cornell Tech. All rights reserved.
//

import UIKit
import Gloss

public class CTFAppConfigPage: Decodable {
    
    public let title: String
    public let shortTitle: String?
    public let activityFileName: String
    
    // MARK: - Deserialization
    
    required public init?(json: JSON) {
        
        guard let title: String = "title" <~~ json,
            let activityFileName: String = "activityFileName" <~~ json else {
                return nil
        }
        self.title = title
        self.shortTitle = "shortTitle" <~~ json
        self.activityFileName = activityFileName
        
    }

}
