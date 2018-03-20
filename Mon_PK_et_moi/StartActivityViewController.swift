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
    
    var seconds = 60
    var timer = Timer()
    var isTimerRunning = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func startButton(_ sender: UIButton) {
        
    }
    
    @IBAction func stopButton(_ sender: Any) {
        
    }
    
    func runTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self,   selector: (#selector(self.updateTimer)), userInfo: nil, repeats: true)
    }
    
    func updateTimer() {
        seconds -= 1     //This will decrement(count down)the seconds.
        durationPicker.date -= 1 //This will update the duration picker.
    }
    
}
