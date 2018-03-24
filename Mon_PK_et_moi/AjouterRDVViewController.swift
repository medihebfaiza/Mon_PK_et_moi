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
    
    func entityIsEmpty() -> Bool
    {
        
        guard let appDel = UIApplication.shared.delegate as? AppDelegate else{return false}
        let context = appDel.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Medecin")
        guard NSEntityDescription.entity(forEntityName: "Medecin", in: context) != nil else {fatalError("Failed to initialize Medicament entity description")}
        do{
            let results:NSArray? = try context.fetch(request) as NSArray
            if let res = results
            {
                return res.count == 0
            }
            else
            {
                return true
            }
        }catch {return false}
    }
    
    /// Insert some demo data into the Medecin entity
    func seedMedecins(){
        if (entityIsEmpty()){
            guard let entity =  NSEntityDescription.entity(forEntityName: "Medecin", in: CoreDataManager.context)   else {fatalError("Failed to initialize Evenement entity description")}
            let medecin1 = Medecin(entity: entity, insertInto: CoreDataManager.context)
            medecin1.nom = "medecin 1"
            let medecin2 = Medecin(entity: entity, insertInto: CoreDataManager.context)
            medecin2.nom = "medecin 2"
            let medecin3 = Medecin(entity: entity, insertInto: CoreDataManager.context)
            medecin3.nom = "medecin 3"
        
            if let error = CoreDataManager.save() {
            DialogBoxHelper.alert(view: self, error: error)
            }
        }
    }
}
