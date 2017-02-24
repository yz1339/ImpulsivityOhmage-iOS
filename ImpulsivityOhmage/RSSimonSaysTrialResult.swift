//
//  RSSimonSaysTrialResult.swift
//  ImpulsivityOhmage
//
//  Created by James Kizer on 2/23/17.
//  Copyright © 2017 Foundry @ Cornell Tech. All rights reserved.
//

import UIKit

public struct RSSimonSaysResponse {
    let reponse: RSSimonSaysStimulus
    let reponseTime: TimeInterval
}

public struct RSSimonSaysTrialResult {
    
    let trial: RSSimonSaysTrial
    let correct: Bool
    let responseSequence: [RSSimonSaysResponse]

}
