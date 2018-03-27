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
    var config : [Configuration] = []

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
        loadConfig()
    }

    /// Is called when the pressButton is pressed. Modifies the Config table in the persistent layer depending on which TextField was modified.
    /// - Precondition:
    /// - Parameter index: <#index description#>
    /// - Returns: <#return value description#>
    @IBAction func pressbutton(_ sender: Any) {
        
        
        if (prenomField.text != ""){
            config[0].prenom = prenomField.text
        }
        if (nomField.text != ""){
            config[0].nom = nomField.text
            
        }
        config[0].dateNaissance = String(describing: dateNaissanceField.date)

        config[0].civilite = civilite[civilitePicker.selectedRow(inComponent: 0)]
        prenomField.text = ""
        nomField.text = ""

        do{
            try CoreDataManager.context.save()
            DialogBoxHelper.alert(view: self, withTitle: "", andMessage: "Modifications correctement effectuées.")
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

    func seedConfig()
    {
        if (CoreDataManager.entityIsEmpty(entityName : "Configuration"))
        {
            guard let entity =  NSEntityDescription.entity(forEntityName: "Configuration", in: CoreDataManager.context) else {fatalError("Failed to initialize Configuration entity description")}
            let configuration = Configuration(entity: entity, insertInto: CoreDataManager.context)
            configuration.nom = ""
            configuration.prenom = ""

            if let error = CoreDataManager.save() {
                DialogBoxHelper.alert(view: self, error: error)
            }
        }
    }

}
