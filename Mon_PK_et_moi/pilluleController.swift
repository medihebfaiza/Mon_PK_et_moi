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
    
    /// Adds a new Traitement in the coredata
    /// - Precondition:
    /// - Parameter index: <#index description#>
    /// - Returns: <#return value description#>
    @IBAction func validerPress(_ sender: Any) {
        let debutPrise = debutprise.date
        let finPrise = finprise.date
        let heurePrise = heureprise.date
        let medicament = pilluleList[choixmedicament.selectedRow(inComponent: 0)]
        if (finPrise >= debutPrise){
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
            DialogBoxHelper.alert(view: self, withTitle: "", andMessage: "Traitement ajouté avec succés.")
        }
        else{
            DialogBoxHelper.alert(view: self, withTitle: "Erreur", andMessage:"La date de début doit être inférieure à la date de fin.")
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let gregorian = Calendar(identifier: .gregorian)
        let now = Date()
        var components = gregorian.dateComponents([.year, .month, .day, .hour, .minute, .second], from: now)
        //components.day = 1
        components.hour = 0
        components.minute = 0
        components.second = 0
        let date1 = gregorian.date(from: components)!
        var components2 = gregorian.dateComponents([.year, .month, .day, .hour, .minute, .second], from: now)
        //components.day = 1
        components2.hour = 23
        components2.minute = 59
        components2.second = 59
        let date2 = gregorian.date(from: components2)!
        debutprise.date = date1
        finprise.date = date2
        
        seedMedicament()
        loadMedicament()
    }
    
    
    /// Is called when the view is loaded, adds in the coredata Medicament if the coredata entity is empty.
    /// - Precondition:
    /// - Returns:
    func seedMedicament(){
        if (MedicamentDAO.count == 0){
            let _ = Medicament(nom : "Modopar", dose : "250")
            let _ = Medicament(nom : "Modopar", dose : "125")
            let _ = Medicament(nom : "Modopar", dose : "62,5")
            let _ = Medicament(nom : "Sinemet", dose : "250")
            let _ = Medicament(nom : "Sinemet", dose : "100")
            let _ = Medicament(nom : "Modopar LP", dose : "125")
            let _ = Medicament(nom : "Modopar Disp", dose : "125")
            let _ = Medicament(nom : "Sinemet LP", dose : "100")
            let _ = Medicament(nom : "Sinemet LP", dose : "200")
            let _ = Medicament(nom : "Stalevo", dose : "50")
            let _ = Medicament(nom : "Stalevo", dose : "75")
            let _ = Medicament(nom : "Stalevo", dose : "100")
            let _ = Medicament(nom : "Stalevo", dose : "125")
            let _ = Medicament(nom : "Stalevo", dose : "150")
            let _ = Medicament(nom : "Stalevo", dose : "175")
            let _ = Medicament(nom : "Stalevo", dose : "200")
            
            let _ = Medicament(nom : "Parlodel", dose : "2,5")
            let _ = Medicament(nom : "Parlodel", dose : "5")
            let _ = Medicament(nom : "Parlodel", dose : "10")
            let _ = Medicament(nom : "Trivastal", dose : "20")
            let _ = Medicament(nom : "Trivastal LP", dose : "50")
            let _ = Medicament(nom : "Sifrol", dose : "0,18")
            let _ = Medicament(nom : "Sifrol", dose : "0,7")
            let _ = Medicament(nom : "Sifrol LP", dose : "0,26")
            
            let _ = Medicament(nom : "Sifrol LP", dose : "0,52")
            
            let _ = Medicament(nom : "Sifrol LP", dose : "1,05")
            
            let _ = Medicament(nom : "Sifrol LP", dose : "2,1")
            
            let _ = Medicament(nom : "Requip", dose : "0,25")
            
            let _ = Medicament(nom : "Requip", dose : "0,5")
            
            let _ = Medicament(nom : "Requip", dose : "1")
            
            let _ = Medicament(nom : "Requip", dose : "2")
            
            let _ = Medicament(nom : "Requip", dose : "5")
            
            let _ = Medicament(nom : "Requip LP", dose : "2")
            
            let _ = Medicament(nom : "Requip LP", dose : "4")
            
            let _ = Medicament(nom : "Requip LP", dose : "8")
            let _ = Medicament(nom : "Neupro (Patch)", dose : "2")
            
            let _ = Medicament(nom : "Neupro (Patch)", dose : "4")
            
            let _ = Medicament(nom : "Neupro (Patch)", dose : "6")
            let _ = Medicament(nom : "Neupro (Patch)", dose : "8")
            
            let _ = Medicament(nom : "Mantadix", dose : "100")
            
            let _ = Medicament(nom : "Azilect", dose : "1")
            let _ = Medicament(nom : "Comtan", dose : "200")
            
            let _ = Medicament(nom : "Artane", dose : "2")
            let _ = Medicament(nom : "Artane", dose : "5")
            let _ = Medicament(nom : "Parkinane LP", dose : "2")
            let _ = Medicament(nom : "Parkinane LP", dose : "5")
            
            let _ = Medicament(nom : "Lepticur", dose : "10")
            
            let _ = Medicament(nom : "Leponex", dose : "25")
            let _ = Medicament(nom : "Leponex", dose : "100")
            
            let _ = Medicament(nom : "Exelon", dose : "1,5")
            
            let _ = Medicament(nom : "Exelon", dose : "3")
            let _ = Medicament(nom : "Exelon", dose : "4,5")
            
            let _ = Medicament(nom : "Exelon", dose : "6")
            
            let _ = Medicament(nom : "Exelon (Patch)", dose : "4,6")
            
            let _ = Medicament(nom : "Exelon (Patch)", dose : "9,5")
            
            if let error = CoreDataManager.save() {
                DialogBoxHelper.alert(view: self, error: error)
            }
        }
    }
    /// Is called to load the Medicament from the persistent layer to the pilluleList argument. Sorts by alphabetical order on the name.
    /// - Precondition: the Medicament table must not be empty.
    /// - Returns:
    func loadMedicament(){
        let request : NSFetchRequest<Medicament> = Medicament.fetchRequest()
        do {
            try self.pilluleList = CoreDataManager.context.fetch(request)
        }
        catch let error as NSError{
            DialogBoxHelper.alert(view: self, error: error)
        }
        pilluleList.sort(by: {$0.nom > $1.nom})
    }

}
