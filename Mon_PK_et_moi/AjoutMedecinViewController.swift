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
    
    var medecins : [Medecin] = []
    /// Saves a Medecin in the coredata and checks if every field has been completed.
    /// - Precondition:
    /// - Parameter index: <#index description#>
    /// - Returns: <#return value description#>
    @IBAction func validerButton(_ sender: Any) {
        if (nomTextField.text == "" || prenomTextField.text == "" || telTextField.text == "") {
            DialogBoxHelper.alert(view: self, withTitle: "Echec", andMessage: "Remplissez tous les champs pour valider.")
        }
        else{
            guard let entity =  NSEntityDescription.entity(forEntityName: "Medecin", in: CoreDataManager.context) else     {fatalError("Failed to initialize Medecin entity description")}
            let medecin = Medecin(entity: entity, insertInto: CoreDataManager.context)
            medecin.nom = nomTextField.text
            medecin.prenom = prenomTextField.text
            medecin.numTelephone = telTextField.text
            do {
                try CoreDataManager.context.save()
                nomTextField.text = ""
                prenomTextField.text = ""
                telTextField.text = ""
            }
            catch let error as NSError{
                DialogBoxHelper.alert(view: self, error: error)
            }
        }
    }
}
