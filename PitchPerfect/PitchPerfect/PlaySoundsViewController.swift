//
//  PlaySoundsViewController.swift
//  PitchPerfect
//
//  Created by JSkophammer on 7/7/16.
//  Copyright © 2016 JSkophammer. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController {
    
    @IBOutlet weak var snailButton: UIButton!
    @IBOutlet weak var chipmunkButton: UIButton!
    @IBOutlet weak var rabbitButton: UIButton!
    @IBOutlet weak var vaderButton: UIButton!
    @IBOutlet weak var echoButton: UIButton!
    @IBOutlet weak var reverbButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    
    var recordedAudioURL: NSURL!
    var audioFile: AVAudioFile!
    var audioEngine: AVAudioEngine!
    var audioPlayerNode: AVAudioPlayerNode!
    var stopTimer: NSTimer!
    
    enum ButtonType: Int { case Slow = 0, Fast, Chipmunk, Vader, Echo, Reverb }
    
    
    @IBAction func playSoundForButton(sender: UIButton) {
        print("Play Sound Button Pressed", terminator: "")
    }
    

    @IBAction func stopButtonPressed(sender: UIButton) {
        print("Stop Button Pressed")
        stopAudio()
    }
    
    
    @IBAction func playChipmunkSound(sender: UIButton) {
        print("Play Chipmunk Sound")
        playSound(pitch: 1000)
        configureUI(.Playing)
    }
    
    @IBAction func playVaderSound(sender: UIButton) {
        print("Play Vader Sound")
        playSound(pitch: -1000)
        configureUI(.Playing)
    }
    
    @IBAction func playSnailSound(sender: UIButton) {
        print("Play Snail Sound")
        playSound(rate: 0.5)
        configureUI(.Playing)
    }
    
    @IBAction func playRabbitSound(sender: UIButton) {
        print("Play Rabbit Sound")
        playSound(rate: 1.5)
        configureUI(.Playing)
    }
    
    @IBAction func playEchoSound(sender: UIButton) {
        print("Play Echo Sound")
        playSound(echo: true)
        configureUI(.Playing)
    }
    
    @IBAction func playReverbSound(sender: UIButton) {
        print("Play Reverb Sound")
        playSound(reverb: true)
        configureUI(.Playing)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        print("PlaySoundsViewControllerLoaded")
        setupAudio()
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(animated: Bool) {
        configureUI(.NotPlaying)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
