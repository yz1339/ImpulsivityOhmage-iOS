//
//  CTFMultipleChoice.swift
//  ImpulsivityOhmage
//
//  Created by James Kizer on 2/10/17.
//  Copyright © 2017 Foundry @ Cornell Tech. All rights reserved.
//

import UIKit
import ResearchSuiteTaskBuilder
import ResearchKit

class CTFMultipleChoice: RSTBMultipleChoiceStepGenerator {
    
    override open func generateChoices(items: [RSTBChoiceStepDescriptor.ChoiceItem], valueSuffix: String?, shouldShuffle: Bool?) -> [ORKTextChoice] {
        
        let shuffledItems = items.shuffled(shouldShuffle: true)
        
        return shuffledItems.map { item in
            
            return ORKTextChoice(
                text: item.text,
                detailText: item.detailText,
                value: item.value,
                exclusive: item.exclusive)
        }
    }

}
