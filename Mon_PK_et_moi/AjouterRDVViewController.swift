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
    
    
    var medecinList : [Medecin] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.seedMedecins()
        self.loadMedecins()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
    
    func loadMedecins() {
        guard let appDel = UIApplication.shared.delegate as? AppDelegate else{return}
        let context = appDel.persistentContainer.viewContext
        let request : NSFetchRequest<Medecin> = Medecin.fetchRequest()
        do {
            try self.medecinList = context.fetch(request)
        }
        catch let error as NSError{
            self.alertError(errorMsg : "\(error)", userInfo : "\(error.userInfo)")
        }
    }
    
    
    @IBAction func saveRDV(_ sender: Any) {
        guard let appDel = UIApplication.shared.delegate as? AppDelegate else{return}
        let context = appDel.persistentContainer.viewContext
        
        let rdvDate = datePicker.date
        let medecin = medecinList[medecinPicker.selectedRow(inComponent: 0)]
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        print("Enregistrement du rdv avec  : " + medecin.nom! + " a la date : "+formatter.string(from: rdvDate))
        
        guard let entity =  NSEntityDescription.entity(forEntityName: "Rendezvous", in: context) else {fatalError("Failed to initialize Evenement entity description")}
        
        let rdvToSave = Rendezvous(entity: entity, insertInto: context)
        //rdvToSave.date = rdvDate as NSDate
        rdvToSave.estdemandepar = medecin
        //medecin.addToRendezvous(rdvToSave)
        
        do {
            try context.save()
        }
        catch let error as NSError{
            self.alertError(errorMsg : "\(error)", userInfo : "\(error.userInfo)")
        }
    }
    
    func seedMedecins(){
        guard let appDel = UIApplication.shared.delegate as? AppDelegate else{return}
        let context = appDel.persistentContainer.viewContext
        guard let entity =  NSEntityDescription.entity(forEntityName: "Medecin", in: context) else {fatalError("Failed to initialize Evenement entity description")}
        let medecin1 = Medecin(entity: entity, insertInto: context)
        medecin1.nom = "medecin 1"
        let medecin2 = Medecin(entity: entity, insertInto: context)
        medecin2.nom = "medecin 2"
        let medecin3 = Medecin(entity: entity, insertInto: context)
        medecin3.nom = "medecin 3"
        do {
            try context.save()
        }
        catch let error as NSError{
            self.alertError(errorMsg : "\(error)", userInfo : "\(error.userInfo)")
        }
    }
    
    func alertError(errorMsg error : String, userInfo user: String = ""){
        let alert = UIAlertController(title : error, message : user, preferredStyle : .alert)
        let cancelAction = UIAlertAction(title : "Ok", style : .default)
        alert.addAction(cancelAction)
        present(alert,animated: true)
    }
}
