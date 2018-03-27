//
//  AjoutMedecinViewController.swift
//  Mon_PK_et_moi
//
//  Created by Hugo LECLER on 24/03/2018.
//  Copyright © 2018 FAIZA&LECLER. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class AjoutMedecinViewController: UIViewController{
    @IBOutlet weak var nomTextField: UITextField!

    @IBOutlet weak var prenomTextField: UITextField!

    @IBOutlet weak var telTextField: UITextField!
    
    var newMedecin : Medecin?
    
    /// Saves a Medecin in the coredata and checks if every field has been completed.
    /// - Precondition:
    /// - Parameter index: <#index description#>
    /// - Returns: <#return value description#>
    @IBAction func validerButton(_ sender: Any) {
        if (nomTextField.text == "" || prenomTextField.text == "" || telTextField.text == "") {
            DialogBoxHelper.alert(view: self, withTitle: "Echec", andMessage: "Remplissez tous les champs pour valider.")
        }
        else{
            self.newMedecin = Medecin(nom: nomTextField.text!,prenom: prenomTextField.text!, numTelephone: telTextField.text!)
            
            if let error = MedecinDAO.save() {
                DialogBoxHelper.alert(view: self, error: error)
            }
            else {
                nomTextField.text = ""
                prenomTextField.text = ""
                telTextField.text = ""
            }
        }
    }
}
