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
        return pilluleList[row].nom  + " " + pilluleList[row].dose
    }
    
    @IBAction func validerPress(_ sender: Any) {
        let debutPrise = debutprise.date
        let finPrise = finprise.date
        let heurePrise = heureprise.date
        let medicament = pilluleList[choixmedicament.selectedRow(inComponent: 0)]
        
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
    override func viewDidLoad() {
        super.viewDidLoad()
        seedMedicament()
        loadMedicament()
    }
    
    
    
    func seedMedicament(){
        if (MedicamentDAO.count == 0){
            let _ = Medicament(nom : "Modopar", dose : "250")
            let _ = Medicament(nom : "Modopar", dose : "125")
            let _ = Medicament(nom : "Modopar", dose : "62,5")
            let _ = Medicament(nom : "Sinemet", dose : "250")
            let _ = Medicament(nom : "Sinemet", dose : "100")
            
            if let error = CoreDataManager.save() {
                DialogBoxHelper.alert(view: self, error: error)
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
    }

}
