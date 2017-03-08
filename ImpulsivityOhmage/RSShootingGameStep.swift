//
//  RSShootingGameStep.swift
//  ImpulsivityOhmage
//
//  Created by Yating Zhan on 3/7/17.
//  Copyright © 2017 Foundry @ Cornell Tech. All rights reserved.
//

import UIKit
import ResearchKit

class RSShootingGameStep: ORKStep {
    var difficulty: Int = 1
    var maxResponseTime: TimeInterval = 5.0
    
    open override func stepViewControllerClass() -> AnyClass {
        return RSShootingGameStepViewController.self
    }
}
