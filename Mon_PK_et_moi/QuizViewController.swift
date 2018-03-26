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


class QuizViewController : UIViewController, UIPickerViewDataSource, UIPickerViewDelegate{
    @IBOutlet weak var radio1: RadioButton!
    @IBOutlet weak var radio2: RadioButton!
    @IBOutlet weak var radio3: RadioButton!
    @IBOutlet weak var radio4: RadioButton!
    @IBOutlet weak var radio5: RadioButton!
    
    lazy var radioButtons: [RadioButton] = {
        return [
            self.radio1,
            self.radio2,
            self.radio3,
            self.radio4,
            self.radio5,
            ]
    }()
    
    lazy var nbPrises:[String] = ["1","2","3","4","5","6+"]
    
    @IBOutlet weak var nbPrisesPicker: UIPickerView!
    
    @IBAction func onRadioButton1Clicked(_ sender: RadioButton) {
        updateRadioButton(sender)
    }
    @IBAction func onRadioButton2Clicked(_ sender: RadioButton) {
        updateRadioButton(sender)
    }
    
    func updateRadioButton(_ sender: RadioButton){
        radioButtons.forEach { $0.isSelected = false }
        sender.isSelected = !sender.isSelected
        
    }
    
    func getSelectedRadioButton() -> RadioButton? {
        var radioButton: RadioButton?
        radioButtons.forEach { if($0.isSelected){ radioButton =  $0 } }
        return radioButton
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return nbPrises.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return nbPrises[row]
    }
    
    @IBAction func enregistrerReponse(_ sender: Any) {
        var libelleReponse : String
        switch getSelectedRadioButton(){
        case self.radio1?:
            libelleReponse = "Toutes les prises"
            break
        case self.radio2?:
            libelleReponse = "La plupart des prises"
        case self.radio3?:
            libelleReponse = "Quelques prises"
        case self.radio4?:
            libelleReponse = "Aucune des prises"
        case self.radio5?:
            libelleReponse = "J'ai oublié " + nbPrises[nbPrisesPicker.selectedRow(inComponent: 1)] + " prises"
        default:
            DialogBoxHelper.alert(view: self, withTitle: "", andMessage: "Veuillez choisir une réponse")
            return
        }
        
        let dateReponse = Date()

        let newReponse = Reponse(date: dateReponse as NSDate, libelle: libelleReponse)
        
        if let error = ReponseDAO.save() {
            DialogBoxHelper.alert(view: self, error: error)
        }
        else {
            DialogBoxHelper.alert(view: self, withTitle: "", andMessage: "Réponse enregistré avec succés.")
        }
        
    }
    
}
