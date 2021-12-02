//
//  ViewController.swift
//  pitch perfect
//
//  Created by Manish raj(MR) on 08/08/21.
//

import UIKit
import AVFoundation

class RecordSoundsViewController: UIViewController, AVAudioRecorderDelegate {
    
    var audioRecorder : AVAudioRecorder!

    @IBOutlet weak var recorderlable: UILabel!
    @IBOutlet weak var Recordbutton: UIButton!
    @IBOutlet weak var stopRecordingbutton: UIButton!
    
    enum ContentMode : Int{
        case scaleAspectFit
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        stopRecordingbutton.isEnabled = false
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("viewWillAppear is called")
    }
    
     func configueUI(_ isRecording: Bool) {
        stopRecordingbutton.isEnabled = isRecording
        Recordbutton.isEnabled = !isRecording
        recorderlable.text = isRecording ? "Recording ..." : "Tap To Record"
    }
    
    @IBAction func recordaudio(_ sender: Any) {
        configueUI(isRecording: Bool)
        let dirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory,.userDomainMask, true)[0] as String
        let recordingName = "recordedVoice.wav"
        let pathArray = [dirPath, recordingName]
        let filePath = URL(string: pathArray.joined(separator: "/"))

        
        let session = AVAudioSession.sharedInstance()
        try! session.setCategory(AVAudioSession.Category.playAndRecord, mode: AVAudioSession.Mode.default, options: AVAudioSession.CategoryOptions.defaultToSpeaker)
        
        try! audioRecorder = AVAudioRecorder(url: filePath!, settings: [:])
        audioRecorder.delegate = self
        audioRecorder.isMeteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
    }
    @IBAction func stopRecording(_ sender: Any) {
        configueUI(isRecording: Bool)
        audioRecorder.stop()
        let audioSession = AVAudioSession.sharedInstance()
        try! audioSession.setActive(false)
    }
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if flag{
            performSegue(withIdentifier: "Stoprecording", sender: audioRecorder.url)
        }
        else{
            print("recording was not successful")
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Stoprecording"{
            let playSoundVC = segue.destination as! PlaySoundsViewController
            let recordedAudioURL = sender as! URL
            playSoundVC.recordedAudioURL = recordedAudioURL
        }
    }
}


