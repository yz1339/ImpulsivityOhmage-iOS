//
//  RSSimonToneGenerator.swift
//  ImpulsivityOhmage
//
//  Created by James Kizer on 2/24/17.
//  Copyright © 2017 Foundry @ Cornell Tech. All rights reserved.
//

import UIKit
import TGSineWaveToneGenerator
import AudioToolbox

class RSSimonToneGenerator: NSObject {
    
    private static let frequencyMap: [RSSimonSaysStimulus: Double] = [
        .blue: 329.63 * 2.0,
        .yellow: 277.18 * 2.0,
        .red: 220.00 * 2.0,
        .green: 164.81 * 2.0
    ]
    
    static let maxAmplitude: Double = 0.8
    
    var toneGeneratorMap = [RSSimonSaysStimulus: TGSineWaveToneGenerator]()
    var errorTone = TGSineWaveToneGenerator(frequency: CGFloat(200.00), amplitude: CGFloat(RSSimonToneGenerator.maxAmplitude))
    
    override init() {
        super.init()
        
        RSSimonToneGenerator.frequencyMap.forEach { (pair) in
            let tg = TGSineWaveToneGenerator(frequency: CGFloat(pair.1), amplitude: CGFloat(RSSimonToneGenerator.maxAmplitude))
            self.toneGeneratorMap[pair.0] = tg
        }
        
    }
    
    func play(stimulus: RSSimonSaysStimulus) {
        if let tg = self.toneGeneratorMap[stimulus] {
            tg.play()
        }
    }
    
    func playError() {
        errorTone.play()
        AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
    }
    
    func stopError() {
        errorTone.stop()
    }
    
    func stop(stimulus: RSSimonSaysStimulus) {
        if let tg = self.toneGeneratorMap[stimulus] {
            tg.stop()
        }
        
    }
    
    func playAll(duration: TimeInterval) {
        toneGeneratorMap.forEach { (pair) in
            
            let tg = pair.1
            tg.play(forDuration: duration)
            
        }
    }
    
    
    
}
