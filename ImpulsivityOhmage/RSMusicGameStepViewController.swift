//
//  RSMusicGameStepViewController.swift
//  ImpulsivityOhmage
//
//  Created by Yating Zhan on 3/13/17.
//  Copyright © 2017 Foundry @ Cornell Tech. All rights reserved.
//

import UIKit
import ResearchKit
import AVFoundation
import Darwin
import sdlrkx


class RSMusicGameStepViewController: ORKStepViewController {
    
    
    var softMusicURL = URL(fileURLWithPath: Bundle.main.path(forResource: "Seeger", ofType: "mp3")!)
    var happyMusicURL = URL(fileURLWithPath: Bundle.main.path(forResource: "Big_Hands", ofType: "mp3")!)
    var epicMusicURL = URL(fileURLWithPath: Bundle.main.path(forResource: "Castello_Oak", ofType: "mp3")!)
    let numberOfTrials = 10
    let timeInterval = 3 // number of seconds in one trial
    let timer = Timer()
    
    @IBOutlet var buttons: [UIButton]!
    
    var URLs : [URL] = []
    
    
    var audioPlayer = AVAudioPlayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        URLs = [softMusicURL, happyMusicURL, epicMusicURL]
        let random = Int (arc4random_uniform(UInt32(3)))
        do {
           audioPlayer = try AVAudioPlayer(contentsOf: URLs[random])
        } catch {
            print("Error while assign audioPlayer")
        }
        audioPlayer.play()
        
        for i in 0..<buttons.count{
            buttons[i].isHidden = true
        }
        
        //playGame()
        // Do any additional setup after loading the view.
    }
    
    
    func buttonShow() {
        let randomButton = Int(arc4random_uniform(UInt32(buttons.count)))
        buttons[randomButton].isHidden = false
    }
    func delayWithSeconds(_ seconds: Double, completion: @escaping () -> ()) {
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
            completion()
        }
    }

//    func playGame() {
//        let group = DispatchGroup()
//        for i in 0...self.numberOfTrials {
//                group.enter()
//                print("!!!!!!!!",i)
//                //let randomTime = Int(arc4random_uniform(UInt32(timeInterval))) + 1
//                //print(randomTime)
//    //            let randomButton = Int(arc4random_uniform(UInt32(buttons.count)))
//    //            Timer.scheduledTimer(timeInterval: TimeInterval(randomTime), target: self, selector: (#selector(RSMusicGameStepViewController.buttonShow)), userInfo: nil, repeats: true)
//                /*
//                delay(TimeInterval(randomTime)) {
//                    let randomButton = Int(arc4random_uniform(UInt32(self.buttons.count)))
//                    self.buttons[randomButton].isHidden = false
//                    print("Button", randomButton)
//                
//                    self.delay(TimeInterval(2)) {
//                        self.buttons[randomButton].isHidden = true
//                        print("Button", randomButton)
//                    }
//                }*/
//
//                self.delayWithSeconds(2) {
//                    self.buttons[0].isHidden = false
//                    self.buttons[0].isEnabled = true
//                    self.delayWithSeconds(2) {
//                        self.buttons[0].isHidden = true
//                        group.leave()
//                    }
//                }
//
//            
//            
//        }
//    }
//    

    @IBAction func tab(_ sender: UIButton) {
        print("pressed")
        sender.isHidden = true
        
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        audioPlayer.stop()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
