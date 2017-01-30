//
//  CTFIntermediateResult.swift
//  ImpulsivityOhmage
//
//  Created by James Kizer on 1/29/17.
//  Copyright © 2017 Foundry @ Cornell Tech. All rights reserved.
//

import UIKit

open class CTFIntermediateResult: NSObject {
    
    let type: String!
    var uuid: UUID! = UUID()
    var startDate: Date?
    var endDate: Date?
    
    public init(type: String) {
        self.type = type
        
        super.init()
    }

}
