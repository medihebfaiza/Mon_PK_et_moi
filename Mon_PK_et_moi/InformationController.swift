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

class InformationController: UIViewController {
  
    @IBOutlet weak var prenomField: UITextField!
    @IBOutlet weak var nomField: UITextField!
    @IBOutlet weak var ageField: UITextField!
    @IBOutlet weak var sexeField: UITextField!
    var config : [Configuration] = []
    
    func saveprenom(firstname: String) {
        guard let appDel = UIApplication.shared.delegate as? AppDelegate else{return}
        let context = appDel.persistentContainer.viewContext
        let entity =  NSEntityDescription.entity(forEntityName: "Configuration", in: context)
        
        let config = Configuration(entity: entity!, insertInto: context)
        config.prenomPatient = firstname
        config.nomPatient = "test"
        config.age = 10
        config.sexePatient = "test"
        
        do{
        try context.save()
        } catch let error as NSError{
            self.alertError(errorMsg: "\(error)", userInfo : "\(error.userInfo)")
            return
        }
    }
    
    func savenom(lastname: String) {
        
    }
    
    func saveage(age name: String) {
        
    }
    
    func savesexe(gender name: String) {
        
    }

    func alertError(errorMsg error : String, userInfo user: String = ""){
        let alert = UIAlertController(title : error, message : user, preferredStyle : .alert)
        let cancelAction = UIAlertAction(title : "Ok", style : .default)
        alert.addAction(cancelAction)
        present(alert,animated: true)
    }
    
    @IBAction func pressbutton(_ sender: Any) {
        if (prenomField.text != nil){
            saveprenom(firstname: prenomField.text!)
        }
        if (prenomField.text != nil){
            savenom(lastname: nomField.text!)
        }
        if (prenomField.text != nil){
            saveage(age: ageField.text!)
        }
        if (prenomField.text != nil){
            savesexe(gender: sexeField.text!)
        }
        
        
        
        
                //let conf:Config = Config()
        // Vérification du champs nom
        //TODO
        // Enregistrement dans la config
        /*
        let appDel = UIApplication.shared.delegate as! AppDelegate
        conf.updateNom(newNom: nomField.text!, appDel: appDel)
 
        let newConfig = Configuration(context: PersistenceService.context)
        newConfig.nomPatient = nomField.text
        newConfig.prenomPatient = prenomField.text
        newConfig.sexePatient = sexeField.text
        newConfig.age = Int16(ageField.text!)!
        print("saving ... "+newConfig.nomPatient!+newConfig.prenomPatient!+newConfig.sexePatient!)
        PersistenceService.saveContext()*/
    }
    
    
   
    
}
