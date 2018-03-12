//
//  InformationController.swift
//  Mon_PK_et_moi
//
//  Created by Hugo LECLER on 06/03/2018.AppDelegate
//  Copyright © 2018 FAIZA&LECLER. All rights reserved.
//

import Foundation
import UIKit
/*
class InformationController: UIViewController {
    
    @IBOutlet weak var prenomField: UITextField!
    @IBOutlet weak var nomField: UITextField!
    @IBOutlet weak var ageField: UITextField!
    @IBOutlet weak var sexeField: UITextField!
    
    @IBAction func pressbutton(_ sender: Any) {
        //let conf:Config = Config()
        // Vérification du champs nom
        //TODO
        // Enregistrement dans la config
        /*
        let appDel = UIApplication.shared.delegate as! AppDelegate
        conf.updateNom(newNom: nomField.text!, appDel: appDel)
         */
        let newConfig = Configuration(context: PersistenceService.context)
        newConfig.nomPatient = nomField.text
        newConfig.prenomPatient = prenomField.text
        newConfig.sexePatient = sexeField.text
        newConfig.age = Int16(ageField.text!)!
        print("saving ... "+newConfig.nomPatient!+newConfig.prenomPatient!+newConfig.sexePatient!)
        PersistenceService.saveContext()
    }
    
    
    
}*/
