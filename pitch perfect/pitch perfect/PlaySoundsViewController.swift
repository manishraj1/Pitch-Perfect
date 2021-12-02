//
//  PlaySoundsViewController.swift
//  pitch perfect
//
//  Created by Manish raj(MR) on 11/08/21.
//

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController {
    
    @IBOutlet weak var snailButton: UIButton!
    
    @IBOutlet weak var rabbitButton: UIButton!
    
    @IBOutlet weak var vanderButton: UIButton!
    
    @IBOutlet weak var chipmunkButton: UIButton!
    
    @IBOutlet weak var echoButton: UIButton!
    
    @IBOutlet weak var reverbButton: UIButton!
    
    @IBOutlet weak var stoprecordingButton: UIButton!
    
    var recordedAudioURL:URL!
    var audioFile:AVAudioFile!
    var audioEngine:AVAudioEngine!
    var audioPlayerNode: AVAudioPlayerNode!
    var stopTimer: Timer!
    
    enum ButtonType: Int {
        case slow = 0, fast, chipmunk, vader, echo, reverb
    }
    
    @IBAction func playSoundForButton(_sender: UIButton){
        switch(ButtonType(rawValue:_sender.tag)!) {
            case .slow:
                playSound(rate: 0.5)
            case .fast:
                playSound(rate: 1.5)
            case .chipmunk:
                playSound(pitch: 1000)
            case .vader:
                playSound(pitch: -1000)
            case .echo:
                playSound(echo: true)
            case .reverb:
                playSound(reverb: true)
            }

            configureUI(.playing)
    }
    
    @IBAction func stopButtonpressed(_sender: UIButton){
        stopAudio()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        snailButton.imageView?.contentMode = .scaleAspectFit
        rabbitButton.imageView?.contentMode = .scaleAspectFit
        vanderButton.imageView?.contentMode = .scaleAspectFit
        chipmunkButton.imageView?.contentMode = .scaleAspectFit
        echoButton.imageView?.contentMode = .scaleAspectFit
        reverbButton.imageView?.contentMode = .scaleAspectFit
        stoprecordingButton.imageView?.contentMode = .scaleAspectFit
        stoprecordingButton.isEnabled = false
        setupAudio()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureUI(.notPlaying)
    }
}
