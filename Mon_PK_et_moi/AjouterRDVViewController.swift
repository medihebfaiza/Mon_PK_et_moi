//
//  AjouterRDVViewController.swift
//  Mon_PK_et_moi
//
//  Created by Mohamed-Iheb FAIZA on 16/03/2018.
//  Copyright © 2018 FAIZA&LECLER. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class AjouterRDVViewController:UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var medecinPicker: UIPickerView!
    @IBOutlet weak var semestrielSwitch: UISwitch!
    
    var newRDV : Rendezvous?
    var medecinList : [Medecin] = []
    
    // Setup after loading the view
    override func viewDidLoad() {
        super.viewDidLoad()
        datePicker.minimumDate = datePicker.date
        self.seedMedecins()
        self.loadMedecins()
    }
    
    // Dispose of any resources that can be recreated.
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // The number of columns of data
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // The number of rows of data
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return medecinList.count
    }
    
    // The data to return for the row and component (column) that's being passed in
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.medecinList[row].nom
    }
    
    /// Load data from the Medecin entity to the medecinList table
    func loadMedecins() {
        let request : NSFetchRequest<Medecin> = Medecin.fetchRequest()
        do {
            try self.medecinList = CoreDataManager.context.fetch(request)
        }
        catch let error as NSError{
            DialogBoxHelper.alert(view: self, error: error)
        }
    }
    
    /// Save a Rendezvous with a selected Medecin with medecinPicker on a given date with datePicker
    @IBAction func saveRDV(_ sender: Any) {
        let rdvDate = datePicker.date
        let rdvMedecin = medecinList[medecinPicker.selectedRow(inComponent: 0)]
        let rdvSemestriel = semestrielSwitch.isOn
        
        self.newRDV = Rendezvous(date: rdvDate as NSDate, semestriel: rdvSemestriel, medecin: rdvMedecin)
        
        if let error = CoreDataManager.save() {
            DialogBoxHelper.alert(view: self, error: error)
        }
        else {
            DialogBoxHelper.alert(view: self, withTitle: "", andMessage: "Rendez-vous ajouté avec succés.")
        }
    }
    

    /// Insert some demo data into the Medecin entity
    func seedMedecins(){
        if (CoreDataManager.entityIsEmpty(entityName : "Medecin")){
            guard let entity =  NSEntityDescription.entity(forEntityName: "Medecin", in: CoreDataManager.context)   else {fatalError("Failed to initialize Evenement entity description")}
            let medecin1 = Medecin(entity: entity, insertInto: CoreDataManager.context)
            medecin1.nom = "jacques"
            medecin1.prenom = "toto"
            medecin1.numTelephone = "06 20 20 10 10"
            let medecin2 = Medecin(entity: entity, insertInto: CoreDataManager.context)
            medecin2.nom = "faiza"
            medecin2.prenom = "momo"
            medecin2.numTelephone = "06 20 20 10 11"
            let medecin3 = Medecin(entity: entity, insertInto: CoreDataManager.context)
            medecin3.nom = "lecler"
            medecin3.prenom = "hugo"
            medecin3.numTelephone = "06 20 20 10 12"
        
            if let error = CoreDataManager.save() {
            DialogBoxHelper.alert(view: self, error: error)
            }
        }
    }
}
