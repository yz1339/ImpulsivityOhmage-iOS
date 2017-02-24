//
//  RSSimonSaysStep.swift
//  ImpulsivityOhmage
//
//  Created by James Kizer on 2/23/17.
//  Copyright © 2017 Foundry @ Cornell Tech. All rights reserved.
//

import UIKit
import ResearchKit

public class RSSimonSaysStep: ORKStep {
    
    var difficulty: Int = 1
    var maxResponseTime: TimeInterval = 5.0
    
    open func stepViewControllerClass() -> AnyClass {
        return RSSimonSaysStepViewController.self
    }

}
