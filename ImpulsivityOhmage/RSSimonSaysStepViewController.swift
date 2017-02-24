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
    

    static let kTimeConstant = 0.6
    static let kGapLength = 0.1
    static let kMaxResponseTime = 5.0
    static let kInitialCountdown = 5.0
    static let kFlashRisingEdgeLength = 0.00
    static let kFlashFallingEdgeLength = 0.00
    static let kErrorLength = 1.0
    static let kLaunchDelay = 1.0
    static let kEndDelay = 1.0
    static let kInterTrialDelay = 0.5
    
    @IBOutlet weak var simonSaysContainerView: UIView!
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
    
    let toneGenerator = RSSimonToneGenerator()
    
    
    var paused = false
    var pendingTrial: RSSimonSaysTrial?
    var pendingTrialResults: [RSSimonSaysTrialResult]?
    var backgroundObserver: NSObjectProtocol!
    var foregroundObserver: NSObjectProtocol!
    
    var _tapStartHandler: ((RSSimonSaysStimulus) -> Void)?
    var _tapEndHandler: ((RSSimonSaysStimulus) -> Void)?
    
    var cancelAnimations = false
    
    var trialResults: [RSSimonSaysTrialResult]?
    
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
        
        let greenTapGesture = RSSimonSaysGestureRecognizer(onBegin: {
            self._tapStartHandler?(.green)
        }) {
            self._tapEndHandler?(.green)
        }
        
        self.greenView.addGestureRecognizer(greenTapGesture)
        
        let yellowTapGesture = RSSimonSaysGestureRecognizer(onBegin: {
            self._tapStartHandler?(.yellow)
        }) {
            self._tapEndHandler?(.yellow)
        }
        self.yellowView.addGestureRecognizer(yellowTapGesture)
        
        
        let redTapGesture = RSSimonSaysGestureRecognizer(onBegin: {
            self._tapStartHandler?(.red)
        }) {
            self._tapEndHandler?(.red)
        }
        
        self.redView.addGestureRecognizer(redTapGesture)
        
        let blueTapGesture = RSSimonSaysGestureRecognizer(onBegin: {
            self._tapStartHandler?(.blue)
        }) {
            self._tapEndHandler?(.blue)
        }
        
        self.blueView.addGestureRecognizer(blueTapGesture)
        
        let backgroundNotification: Notification.Name = NSNotification.Name.UIApplicationDidEnterBackground
        self.backgroundObserver = NotificationCenter.default.addObserver(forName: backgroundNotification, object: nil, queue: nil) { [weak self] (notification) in
            
            self?.paused = true
            
        }
        
        let foregroudNotification: Notification.Name = NSNotification.Name.UIApplicationDidBecomeActive
        self.foregroundObserver = NotificationCenter.default.addObserver(forName: foregroudNotification, object: nil, queue: nil) { [weak self] (notification) in
            
            self?.paused = false
            
        }
        
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self.backgroundObserver)
        NotificationCenter.default.removeObserver(self.foregroundObserver)
    }
    
    func delay(_ delay:TimeInterval, closure:@escaping ()->()) {
        DispatchQueue.main.asyncAfter(
            deadline: DispatchTime.now() + Double(Int64(delay * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC), execute: closure)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.cancelAnimations = false

        if let pendingTrial = self.pendingTrial,
            let pendingTrialResults = self.pendingTrialResults {
            self.delay(RSSimonSaysStepViewController.kLaunchDelay) {
                self.performTrial(trial: pendingTrial, trialResults: pendingTrialResults) { (trialResults) in
                    self.trialResults = trialResults
                    self.goForward()
                }
            }
            
        }
        else {
            let firstTrial = self.createTrial(previousTrial: nil)
            self.delay(RSSimonSaysStepViewController.kLaunchDelay) {
                self.performTrial(trial: firstTrial, trialResults: []) { (trialResults) in
                    self.trialResults = trialResults
                    self.goForward()
                }
            }
            
        }

    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.cancelAnimations = true
    }
    
    //UI Stuff
    private func startFlash(view: UIView, delay: TimeInterval = 0.0, completion: ((Bool) -> Void)? = nil) {
        UIView.animate(
            withDuration: RSSimonSaysStepViewController.kFlashRisingEdgeLength,
            delay: delay,
            options: .curveLinear,
            animations: {
            view.alpha = 1.0
        }, completion: completion)
    }
    
    private func flashViewForStimulus(stimulus: RSSimonSaysStimulus) -> UIView {
        switch stimulus {
        case .green:
            return self.greenFlashView
        case .yellow:
            return self.yellowFlashView
        case .blue:
            return self.blueFlashView
        case .red:
            return self.redFlashView
        }
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
    
    private func startFlash(stimulus: RSSimonSaysStimulus, delay: TimeInterval = 0.0, completion: ((Bool) -> Void)? = nil) {
        
        let flashView = self.flashViewForStimulus(stimulus: stimulus)
        self.startFlash(view: flashView, delay: delay) { (completed) in
            self.toneGenerator.play(stimulus: stimulus)
            completion?(completed)
        }
        
    }
    
    private func endFlash(stimulus: RSSimonSaysStimulus, delay: TimeInterval = 0.0, completion: ((Bool) -> Void)? = nil) {
        
        let flashView = self.flashViewForStimulus(stimulus: stimulus)
        self.endFlash(view: flashView, delay: delay) { (completed) in
            self.toneGenerator.stop(stimulus: stimulus)
            completion?(completed)
        }
        
    }
    
    private func flashView(stimulus: RSSimonSaysStimulus, duration: TimeInterval, completion: ((Bool) -> Void)? = nil) {
        
        self.startFlash(stimulus: stimulus, completion: { completed in
            
            self.endFlash(stimulus: stimulus, delay: duration, completion: completion)
        
        })
        
    }
    
    private func signalIncorrect(stimulus: RSSimonSaysStimulus, duration: TimeInterval, completion: ((Bool) -> Void)? = nil) {
        
        let flashView = self.flashViewForStimulus(stimulus: stimulus)
        self.startFlash(view: flashView, delay: 0.0) { (completed) in
            self.toneGenerator.playError()
            self.endFlash(view: flashView, delay: duration) { (completed) in
                self.toneGenerator.stopError()
                completion?(completed)
            }
        }
        
    }
    
    private func playSequence(
        stimuli: [RSSimonSaysStimulus],
        stimulusDuration: TimeInterval,
        gapDuration: TimeInterval,
        completion: @escaping ()->Void) {
        
        if self.cancelAnimations {
            completion()
        }
        
        if let first = stimuli.first {
            self.flashView(stimulus: first, duration: stimulusDuration, completion: { (complete) in
                
                self.delay(gapDuration) {
                    let tail = Array(stimuli.dropFirst())
                    self.playSequence(stimuli: tail, stimulusDuration: stimulusDuration, gapDuration: gapDuration, completion: completion)
                }
                
            })
        }
        else {
            completion()
        }
        
    }
    
    private func playSequence(forTrial trial: RSSimonSaysTrial, completion: @escaping ()->Void) {
        
        self.playSequence(stimuli: trial.stimulusSequence, stimulusDuration: trial.stimulusLength, gapDuration: RSSimonSaysStepViewController.kGapLength, completion: completion)
        
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
    
    //this will set up start and end handlers
    //if start is correct, we will flash view and wait for end handler
    //if start is incorrect, we will flash
    private func monitorForStimulus(stimulus: RSSimonSaysStimulus, completion: @escaping (Bool, RSSimonSaysResponse) -> Void) {
        
        let startTime = Date()
        
        self._tapStartHandler = { tappedStimulus in
            
            let tapTime = Date()
            let tapDelay = tapTime.timeIntervalSince(startTime)
            
            let response = RSSimonSaysResponse(reponse: tappedStimulus, reponseTime: tapDelay)
            
            if stimulus == tappedStimulus {
                self.startFlash(stimulus: stimulus)
                self._tapEndHandler = { tappedStimulus in
                    self.endFlash(stimulus: tappedStimulus, delay: 0.0, completion: { (completed) in
                        
                        completion(true, response)
                        
                    })
                }
                
            }
            else {
                self.signalIncorrect(stimulus: tappedStimulus, duration: RSSimonSaysStepViewController.kErrorLength, completion: { (completed) in
                    completion(false, response)
                })
            }
        }
        
        self._tapEndHandler = nil
        
        
    }
    
    private func monitorStimuli(stimuli: [RSSimonSaysStimulus], responses: [RSSimonSaysResponse], completion: @escaping (Bool, [RSSimonSaysResponse]) -> Void) {
        //need to go through all the stimuli for this trial
        //get first stimulus
        if let head = stimuli.first {
            self.monitorForStimulus(stimulus: head, completion: { (correct, response) in
                if correct {
                    //recurse
                    let remainingStimuli = Array(stimuli.dropFirst())
                    let accumulatedResponse = responses + [response]
                    self.monitorStimuli(stimuli: remainingStimuli, responses: accumulatedResponse, completion: completion)
                }
                else {
                    completion(false, responses)
                }
            })
        }
        else {
            completion(true, responses)
        }
    }
    
    private func doTrial(trial: RSSimonSaysTrial, completion: @escaping (RSSimonSaysTrialResult) -> Void) {
        
        self.monitorStimuli(stimuli: trial.stimulusSequence, responses: []) { (correct, responses) in
            
            //create new trial result
            let trialResult = RSSimonSaysTrialResult(trial: trial, correct: correct, responseSequence: responses)
            completion(trialResult)
            
        }
        
    }
    
    private func performTrial(trial: RSSimonSaysTrial, trialResults: [RSSimonSaysTrialResult] = [], completion: @escaping ([RSSimonSaysTrialResult]) -> Void) {
        
        //disable user interaction
        self.simonSaysContainerView.isUserInteractionEnabled = false
        
        //play sequence
        self.playSequence(forTrial: trial) { 
            
            self.simonSaysContainerView.isUserInteractionEnabled = true
            self.doTrial(trial: trial, completion: { (trialResult) in
                
                let newTrialResults = trialResults + [trialResult]
                
                if trialResult.correct {
                    let newTrial = self.createTrial(previousTrial: trial)
                    self.delay(RSSimonSaysStepViewController.kInterTrialDelay) {
                        self.performTrial(trial: newTrial, trialResults: newTrialResults, completion: completion)
                    }
                }
                else {
                    self.delay(RSSimonSaysStepViewController.kEndDelay) {
                        completion(newTrialResults)
                    }
                }
            })
            
        }
        
        
    }
    
    @IBAction func skipButtonPressed(_ sender: Any) {
        
        self.goForward()
    }
    
    override var result: ORKStepResult? {
        guard let parentResult = super.result else {
            return nil
        }
        
        if let trialResults = self.trialResults {
            
            let result = RSSimonSaysResult(identifier: step!.identifier)
            result.startDate = parentResult.startDate
            result.endDate = parentResult.endDate
            result.trialResults = trialResults
            
            parentResult.results = [result]
        }
        
        return parentResult
    }
    
}
