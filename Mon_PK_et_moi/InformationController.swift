//
//  InformationController.swift
//  Mon_PK_et_moi
//
//  Created by Hugo LECLER on 06/03/2018.AppDelegate
//  Copyright © 2018 FAIZA&LECLER. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class InformationController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
  
    @IBOutlet weak var prenomField: UITextField!
    @IBOutlet weak var nomField: UITextField!
    var  civilite : [String] = ["Monsieur", "Madame"]
    @IBOutlet weak var dateNaissanceField: UIDatePicker!
    @IBOutlet weak var civilitePicker: UIPickerView!
    
    var config : Configuration?

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // The number of rows of data
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return civilite.count
    }
    
    // The data to return for the row and component (column) that's being passed in
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return civilite[row]
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        seedConfig()
        dateNaissanceField.maximumDate = dateNaissanceField.date
        // Do any additional setup after loading the view, typically from a nib.
        loadConfig()
    }

    /// Is called when the pressButton is pressed. Modifies the Config table in the persistent layer depending on which TextField was modified.
    /// - Precondition:
    /// - Parameter index: <#index description#>
    /// - Returns: <#return value description#>
    @IBAction func pressbutton(_ sender: Any) {
        
        
        if (prenomField.text != ""){
            config!.prenom = prenomField.text!
        }
        if (nomField.text != ""){
            config!.nom = nomField.text!
            
        }
        config!.dateNaissance = String(describing: dateNaissanceField.date)

        config!.civilite = civilite[civilitePicker.selectedRow(inComponent: 0)]
        prenomField.text = ""
        nomField.text = ""

        if let error = ConfigurationDAO.save() {
            DialogBoxHelper.alert(view: self, error: error)
        }
        else {
            DialogBoxHelper.alert(view: self, withTitle: "", andMessage: "Modifications correctement effectuées.")
        }
}
    
    func loadConfig() {
        self.config = ConfigurationDAO.fetchConfig()
    }

    func seedConfig()
    {
        if (ConfigurationDAO.count==0)
        {
            let _ = Configuration(nom: "", prenom: "", dateNaissance: "", civilite: "")

            if let error = CoreDataManager.save() {
                DialogBoxHelper.alert(view: self, error: error)
            }
            else {
                //DialogBoxHelper.alert(view: self, withTitle: "", andMessage: "Evenement ajouté avec succés.")
            }
        }
        else {
            //DialogBoxHelper.alert(view: self, withTitle: "", andMessage: "Evenement ajouté avec succés.")
        }
    }

}
