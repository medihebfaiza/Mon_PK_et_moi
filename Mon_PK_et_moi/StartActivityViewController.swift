//
//  StartActivityViewController.swift
//  Mon_PK_et_moi
//
//  Created by Mohamed-Iheb FAIZA on 20/03/2018.
//  Copyright © 2018 FAIZA&LECLER. All rights reserved.
//

import Foundation
import UIKit

class StartActivityViewController: UIViewController{
    
    @IBOutlet weak var durationPicker: UIDatePicker!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var pauseButton: UIButton!
    
    @IBOutlet weak var activityName: UILabel!
    
    var seconds = 0
    var timer = Timer()
    var isTimerRunning = false
    var resumeTapped = false
    var activitySelected : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityName.text = activitySelected
    }
    
    @IBAction func startButton(_ sender: UIButton) {
        if isTimerRunning == false {
            getDuration()
            runTimer()
        }
        else {
            stopTimer()
        }
    }
    
    @IBAction func pauseButton(_ sender: Any) {
        if self.resumeTapped == false {
            timer.invalidate()
            self.resumeTapped = true
            pauseButton.setTitle("Continuer", for: .normal)
        } else {
            runTimer()
            self.resumeTapped = false
            pauseButton.setTitle("Pause", for: .normal)
        }
    }
    
    
    @IBAction func finishedButton(_ sender: Any) {
        stopTimer()
        self.performSegue(withIdentifier: "finishedActivitySegue", sender: self)
    }
    
    func getDuration() {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm:ss"
        let durationText = formatter.string(from: durationPicker.date)
        let durationTable = durationText.components(separatedBy: ":")
        let hours = Int(durationTable[0])
        let minutes = Int(durationTable[1])
        let seconds = Int(durationTable[2])
        self.seconds = hours! * 60 * 60 + minutes! * 60 + seconds!
    }
    
    func runTimer() {
        isTimerRunning = true
        startButton.setTitle("Arrêter", for: .normal)
        timer = Timer.scheduledTimer(timeInterval: 1, target: self,   selector: (#selector(self.updateTimer)), userInfo: nil, repeats: true)
    }
    
    func stopTimer(){
        timer.invalidate()
        self.seconds = 0
        timeLabel.text = timeString(time: TimeInterval(self.seconds))
        isTimerRunning = false
        startButton.setTitle("Commencer", for: .normal)
    }
    
    func updateTimer() {
        if (seconds == 0){
            stopTimer()
        }
        else {
            seconds -= 1     //This will decrement(count down)the seconds.
            timeLabel.text = timeString(time: TimeInterval(seconds))
        }
    }
    
    func timeString(time:TimeInterval) -> String {
        let hours = Int(time) / 3600
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        return String(format:"%02i:%02i:%02i", hours, minutes, seconds)
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "finishedActivitySegue" {
            if let controller = segue.destination as? FinishedActivityViewController{
                controller.activitySelected = self.activitySelected
            }
        }
    }
    
}
