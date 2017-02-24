//
//  RSSimonSaysTrial.swift
//  ImpulsivityOhmage
//
//  Created by James Kizer on 2/23/17.
//  Copyright © 2017 Foundry @ Cornell Tech. All rights reserved.
//

import UIKit

public enum RSSimonSaysStimulus {
    case red
    case blue
    case yellow
    case green
}

public struct RSSimonSaysTrial {
    
    let stimulusLength: TimeInterval
    let gapLength: TimeInterval
    let maxResponseTime: TimeInterval
    let stimulusSequence: [RSSimonSaysStimulus]

}
