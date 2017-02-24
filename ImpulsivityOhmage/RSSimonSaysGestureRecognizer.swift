//
//  RSSimonSaysGestureRecognizer.swift
//  ImpulsivityOhmage
//
//  Created by James Kizer on 2/24/17.
//  Copyright © 2017 Foundry @ Cornell Tech. All rights reserved.
//

import UIKit
import UIKit.UIGestureRecognizerSubclass

class RSSimonSaysGestureRecognizer: UIGestureRecognizer {
    
    let onBegin: ()->Void
    let onEnd: ()->Void
    
    init(onBegin: @escaping ()->Void, onEnd: @escaping ()->Void) {
        self.onEnd = onEnd
        self.onBegin = onBegin
        super.init(target: nil, action: nil)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent) {
        super.touchesBegan(touches, with: event)
        state = .began
        onBegin()
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent) {
        super.touchesEnded(touches, with: event)
        state = .ended
        onEnd()
    }
    
    
    
    
    

}
