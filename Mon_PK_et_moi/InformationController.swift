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
    //@IBOutlet weak var sexeField: UITextField!
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
    
*/
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        loadConfig()
    }

    /// Is called when the pressButton is pressed. Modifies the Config table in the persistent layer depending on which TextField was modified.
    /// - Precondition:
    /// - Parameter index: <#index description#>
    /// - Returns: <#return value description#>
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
        /*if (sexeField.text != ""){
            config[0].sexePatient = sexeField.text
        }*/
        prenomField.text = ""
        nomField.text = ""
        ageField.text = ""
        //sexeField.text = ""
        
        do{
            try context.save()
        } catch let error as NSError{
            DialogBoxHelper.alert(view: self, error: error)
            return
        }
}
    
    func loadConfig() {
        let request : NSFetchRequest<Configuration> = Configuration.fetchRequest()
        do {
            try self.config = CoreDataManager.context.fetch(request)
        }
        catch let error as NSError{
            DialogBoxHelper.alert(view: self, error: error)
        }
    }
    
    
}
