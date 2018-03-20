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
class pilluleController: UIViewController
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
        return pilluleList[row].nom
    }
    
    @IBAction func validerPress(_ sender: Any) {
        
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        seedMedicament()
    }
    
    
    func entityIsEmpty() -> Bool
    {
        
        guard let appDel = UIApplication.shared.delegate as? AppDelegate else{return false}
        let context = appDel.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Medicament")
        guard NSEntityDescription.entity(forEntityName: "Medicament", in: context) != nil else {fatalError("Failed to initialize Medicament entity description")}
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
    func seedMedicament(){
        if (entityIsEmpty()){
            guard let appDel = UIApplication.shared.delegate as? AppDelegate else{return}
            let context = appDel.persistentContainer.viewContext
            guard let entity =  NSEntityDescription.entity(forEntityName: "Medicament", in: context) else {fatalError("Failed to initialize Medicament entity description")}
            let medicament1 = Medicament(entity: entity, insertInto: context)
            medicament1.nom = "Modopar"
            medicament1.dose = "250"
            let medicament2 = Medicament(entity: entity, insertInto: context)
            medicament2.nom = "Modopar"
            medicament2.dose = "62,5"
            do {
                try context.save()
            }
            catch let error as NSError{
                self.alertError(errorMsg : "\(error)", userInfo : "\(error.userInfo)")
            }
        }
    }

}
