//
//  QuizViewController.swift
//  Mon_PK_et_moi
//
//  Created by Hugo LECLER on 24/03/2018.
//  Copyright © 2018 FAIZA&LECLER. All rights reserved.
//

import Foundation
import UIKit
import CoreData


class QuizViewController : UIViewController{

    @IBOutlet weak var radio1: RadioButton!
    @IBOutlet weak var radio2: RadioButton!
    @IBOutlet weak var radio3: RadioButton!
    @IBOutlet weak var radio4: RadioButton!
    @IBOutlet weak var radio5: RadioButton!
    /*
    lazy var radioButtons: [RadioButton] = {
        return [
            self.radioButton1,
            self.radioButton2,
            ]
    }()
    
    
    @IBAction func onRadioButton1Clicked(_ sender: RadioButton) {
        updateRadioButton(sender)
    }
    @IBAction func onRadioButton2Clicked(_ sender: RadioButton) {
        updateRadioButton(sender)
    }
    
    
    // MAIN Methodes
    func updateRadioButton(_ sender: RadioButton){
        radioButtons.forEach { $0.isSelected = false }
        sender.isSelected = !sender.isSelected
        
    }
    
    func getSelectedRadioButton() -> RadioButton? {
        var radioButton: RadioButton?
        radioButtons.forEach { if($0.isSelected){ radioButton =  $0 } }
        return radioButton
    }*/
    
}
