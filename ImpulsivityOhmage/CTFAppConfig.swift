//
//  CTFAppConfig.swift
//  ImpulsivityOhmage
//
//  Created by James Kizer on 2/11/17.
//  Copyright © 2017 Foundry @ Cornell Tech. All rights reserved.
//

import Gloss

public class CTFAppConfig: Decodable {
    
    public let pages: [CTFAppConfigPage]
    
    // MARK: - Deserialization
    
    required public init?(json: JSON) {
        
        guard let pages: [JSON] = "pages" <~~ json else {
                return nil
        }
        
        self.pages = pages.flatMap { (json) -> CTFAppConfigPage? in
            
            return CTFAppConfigPage(json: json)
            
        }
        
    }

}
