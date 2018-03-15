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
/*
    func saveprenom(firstname: String) {
        guard let appDel = UIApplication.shared.delegate as? AppDelegate else{
            print("error")
            return}
        let context = appDel.persistentContainer.viewContext
        guard let entity =  NSEntityDescription.entity(forEntityName: "Configuration", in: context) else {fatalError("configuration entity failed")}
        
        let config = Configuration(entity: entity, insertInto: context)
        config.prenomPatient = firstname
        
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
*/
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        loadConfig()
    }

    func alertError(errorMsg error : String, userInfo user: String = ""){
        let alert = UIAlertController(title : error, message : user, preferredStyle : .alert)
        let cancelAction = UIAlertAction(title : "Ok", style : .default)
        alert.addAction(cancelAction)
        present(alert,animated: true)
    }
    
    @IBAction func pressbutton(_ sender: Any) {
        guard let appDel = UIApplication.shared.delegate as? AppDelegate else
        {
            print("error")
            return
        }
        let context = appDel.persistentContainer.viewContext
        
        
        
        if (prenomField.text != ""){
            config[0].prenomPatient = prenomField.text
        }
        if (nomField.text != ""){
            config[0].nomPatient = nomField.text
            
        }
        if (ageField.text != ""){
            config[0].age = Int16(ageField.text!)!
        }
        if (sexeField.text != ""){
            config[0].sexePatient = sexeField.text
        }
        
        do{
            try context.save()
        } catch let error as NSError{
            self.alertError(errorMsg: "\(error)", userInfo : "\(error.userInfo)")
            return
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
    
    func loadConfig() {
        guard let appDel = UIApplication.shared.delegate as? AppDelegate else{return}
        let context = appDel.persistentContainer.viewContext
        let request : NSFetchRequest<Configuration> = Configuration.fetchRequest()
        do {
            try self.config = context.fetch(request)
        }
        catch let error as NSError{
            self.alertError(errorMsg : "\(error)", userInfo : "\(error.userInfo)")
        }
    }
    
    
}
