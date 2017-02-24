//
//  RSSimonSaysTrial.swift
//  ImpulsivityOhmage
//
//  Created by James Kizer on 2/23/17.
//  Copyright © 2017 Foundry @ Cornell Tech. All rights reserved.
//

import UIKit

public enum RSSimonSaysStimulus: UInt32 {
    case red
    case blue
    case yellow
    case green
    
    private static let _count: RSSimonSaysStimulus.RawValue = {
        // find the maximum enum value
        var maxValue: UInt32 = 0
        while let _ = RSSimonSaysStimulus(rawValue: maxValue) {
            maxValue += 1
        }
        return maxValue
    }()
    
    static func randomStimulus() -> RSSimonSaysStimulus {
        // pick and return a new value
        let rand = arc4random_uniform(_count)
        return RSSimonSaysStimulus(rawValue: rand)!
    }
    
}

public struct RSSimonSaysTrial {
    
    let stimulusLength: TimeInterval
    let gapLength: TimeInterval
    let maxResponseTime: TimeInterval
    let stimulusSequence: [RSSimonSaysStimulus]

}
