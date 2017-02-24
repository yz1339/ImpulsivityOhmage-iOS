//
//  RSSimonSaysStepViewController.swift
//  ImpulsivityOhmage
//
//  Created by James Kizer on 2/23/17.
//  Copyright © 2017 Foundry @ Cornell Tech. All rights reserved.
//

import UIKit
import ResearchKit


class RSSimonSaysStepViewController: ORKStepViewController {
    
    class TapHandler {
        let closure: ()->Void
        init(closure: @escaping ()->Void) {
            self.closure = closure
        }
        
        func handleTap() {
            self.closure()
        }
    }
    

    static let kTimeConstant = 1.0
    static let kGapLength = 0.2
    static let kMaxResponseTime = 5.0
    static let kInitialCountdown = 5.0
    static let kFlashRisingEdgeLength = 0.00
    static let kFlashFallingEdgeLength = 0.00
    
    @IBOutlet weak var skipButton: UIButton!
    
    @IBOutlet weak var greenView: UIView!
    @IBOutlet weak var greenFlashView: UIView!
    
    
    @IBOutlet weak var yellowView: UIView!
    @IBOutlet weak var yellowFlashView: UIView!
    
    
    @IBOutlet weak var redView: UIView!
    @IBOutlet weak var redFlashView: UIView!
    
    
    @IBOutlet weak var blueView: UIView!
    @IBOutlet weak var blueFlashView: UIView!
    
    var generateStimulusLength: ((Int) -> TimeInterval)?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //
        
        if let step = self.step,
            step.isOptional == false {
            self.skipButton.isHidden = true
        }
        
        if let step = self.step as? RSSimonSaysStep {
            self.generateStimulusLength = RSSimonSaysStepViewController.stimulusLengthGenerator(
                timeConstant: RSSimonSaysStepViewController.kTimeConstant,
                difficulty: step.difficulty
            )
            
            
        }
        
        let greenTapGesture = UITapGestureRecognizer(target: self, action: #selector(RSSimonSaysStepViewController.handleGreenTap))
        self.greenView.addGestureRecognizer(greenTapGesture)
        
        let yellowTapGesture = UITapGestureRecognizer(target: self, action: #selector(RSSimonSaysStepViewController.handleYellowTap))
        self.yellowView.addGestureRecognizer(yellowTapGesture)
        
        
        let redTapGesture = UITapGestureRecognizer(target: self, action: #selector(RSSimonSaysStepViewController.handleRedTap))
        self.redView.addGestureRecognizer(redTapGesture)
        
        let blueTapGesture = UITapGestureRecognizer(target: self, action: #selector(RSSimonSaysStepViewController.handleBlueTap))
        self.blueView.addGestureRecognizer(blueTapGesture)
        
    }
    
    func handleGreenTap(gestureRecognizer: UITapGestureRecognizer) {
        
        self.flashView(view: self.greenFlashView, duration: 0.10)

    }
    
    func handleYellowTap(gestureRecognizer: UITapGestureRecognizer) {
        
        self.flashView(view: self.yellowFlashView, duration: 0.10)
        
    }
    
    func handleRedTap(gestureRecognizer: UITapGestureRecognizer) {
        
        self.flashView(view: self.redFlashView, duration: 0.10)
        
    }
    
    func handleBlueTap(gestureRecognizer: UITapGestureRecognizer) {
        
        self.flashView(view: self.blueFlashView, duration: 0.10)
        
    }
    
    private func startFlash(view: UIView, delay: TimeInterval = 0.0, completion: ((Bool) -> Void)? = nil) {
        UIView.animate(
            withDuration: RSSimonSaysStepViewController.kFlashRisingEdgeLength,
            delay: delay,
            options: .curveLinear,
            animations: {
            view.alpha = 1.0
        }, completion: completion)
    }
    
    private func endFlash(view: UIView, delay: TimeInterval = 0.0, completion: ((Bool) -> Void)? = nil) {
        UIView.animate(
            withDuration: RSSimonSaysStepViewController.kFlashFallingEdgeLength,
            delay: delay,
            options: .curveLinear,
            animations: {
                view.alpha = 0.0
        }, completion: completion)
    }
    
    private func flashView(view: UIView, duration: TimeInterval, completion: ((Bool) -> Void)? = nil) {
        
        self.startFlash(view: view, completion: { completed in
            
            self.endFlash(view: view, delay: duration, completion: completion)
        
        })
        
    }
    
    //fill this in at some point
    private static func generateDecayConstant(difficulty: Int) -> Double {
        return 0.04
    }
    
    private static func stimulusLengthGenerator(timeConstant: TimeInterval, difficulty: Int) -> (Int) -> TimeInterval {
        return { iteration in
            
            let decayConstant = RSSimonSaysStepViewController.generateDecayConstant(difficulty: difficulty)
            return timeConstant * exp(-1.0 * decayConstant * Double(iteration))
            
        }
    }
    
    private static func generateSequence(previousSequence: [RSSimonSaysStimulus]) ->  [RSSimonSaysStimulus] {
        return previousSequence + [RSSimonSaysStimulus.randomStimulus()]
    }
    
    private func createTrial(previousTrial: RSSimonSaysTrial?) -> RSSimonSaysTrial {
        
        let (stimulusLength, sequence): (TimeInterval, [RSSimonSaysStimulus]) = {
            if let previousTrial = previousTrial {
                return (self.generateStimulusLength!(previousTrial.stimulusSequence.count), RSSimonSaysStepViewController.generateSequence(previousSequence: previousTrial.stimulusSequence))
            }
            else {
                return (self.generateStimulusLength!(0), RSSimonSaysStepViewController.generateSequence(previousSequence: []))
            }
        }()
        
        return RSSimonSaysTrial(
            stimulusLength: stimulusLength,
            gapLength: RSSimonSaysStepViewController.kGapLength,
            maxResponseTime: RSSimonSaysStepViewController.kMaxResponseTime,
            stimulusSequence: sequence
        )
    }
    
    
    private func playSequence(forTrial trial: RSSimonSaysTrial, completion: @escaping ()->Void) {
        
        
        
    }
    
    
    @IBAction func skipButtonPressed(_ sender: Any) {
        
        self.goForward()
    }
    
    
}
