//
//  AjoutPilluleControler.swift
//  Mon_PK_et_moi
//
//  Created by Hugo LECLER on 09/03/2018.
//  Copyright © 2018 FAIZA&LECLER. All rights reserved.
//

import Foundation
import UIKit
import CoreData
class pilluleController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource
{
    var pilluleList : [Medicament] = []
    
    
    @IBOutlet weak var choixmedicament: UIPickerView!
    @IBOutlet weak var debutprise: UIDatePicker!
    @IBOutlet weak var finprise: UIDatePicker!
    @IBOutlet weak var heureprise: UIDatePicker!
    
    func alertError(errorMsg error : String, userInfo user: String = ""){
        let alert = UIAlertController(title : error, message : user, preferredStyle : .alert)
        let cancelAction = UIAlertAction(title : "Ok", style : .default)
        alert.addAction(cancelAction)
        present(alert,animated: true)
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // The number of rows of data
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pilluleList.count
    }
    
    // The data to return for the row and component (column) that's being passed in
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pilluleList[row].nom!  + " " + pilluleList[row].dose!
    }
    
    @IBAction func validerPress(_ sender: Any) {
        
        let debutPrise = debutprise.date
        let finPrise = finprise.date
        let heurePrise = heureprise.date
        let medicament = pilluleList[choixmedicament.selectedRow(inComponent: 0)]
        if (finPrise > debutPrise){
        guard let entity =  NSEntityDescription.entity(forEntityName: "Traitement", in: CoreDataManager.context)
            else {
                fatalError("Failed to initialize Evenement entity description")
        }
        let traitementToSave = Traitement(entity: entity, insertInto : CoreDataManager.context)
        traitementToSave.dateDeDebut = debutPrise as NSDate
        traitementToSave.dateDeFin = finPrise as NSDate
        print(heurePrise)
        traitementToSave.heure = heurePrise as NSDate
        traitementToSave.medicament = medicament
        }
        else{
            DialogBoxHelper.alert(view: self, withTitle: "Erreur", andMessage:"La date de début doit être inférieure à la date de fin.")
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        seedMedicament()
        loadMedicament()
    }
    
    
    
    func seedMedicament(){
        if (CoreDataManager.entityIsEmpty(entityName : "Medicament")){
            guard let entity =  NSEntityDescription.entity(forEntityName: "Medicament", in: CoreDataManager.context) else {fatalError("Failed to initialize Medicament entity description")}
            let medicament1 = Medicament(entity: entity, insertInto: CoreDataManager.context)
            medicament1.nom = "Modopar"
            medicament1.dose = "250"
            let medicament2 = Medicament(entity: entity, insertInto: CoreDataManager.context)
            medicament2.nom = "Modopar"
            medicament2.dose = "125"
            let medicament3 = Medicament(entity: entity, insertInto: CoreDataManager.context)
            medicament3.nom = "Modopar"
            medicament3.dose = "62,5"
            let medicament4 = Medicament(entity: entity, insertInto: CoreDataManager.context)
            medicament4.nom = "Sinemet"
            medicament4.dose = "100"
            let medicament5 = Medicament(entity: entity, insertInto: CoreDataManager.context)
            medicament5.nom = "Sinemet"
            medicament5.dose = "250"
            do {
                try CoreDataManager.context.save()
            }
            catch let error as NSError{
                self.alertError(errorMsg : "\(error)", userInfo : "\(error.userInfo)")
            }
        }
    }
    
    func loadMedicament(){
        let request : NSFetchRequest<Medicament> = Medicament.fetchRequest()
        do {
            try self.pilluleList = CoreDataManager.context.fetch(request)
        }
        catch let error as NSError{
            DialogBoxHelper.alert(view: self, error: error)
        }
        pilluleList.sort(by: {$0.nom! > $1.nom!})
    }

}
