//
//  SignalerSymptomeViewController.swift
//  Mon_PK_et_moi
//
//  Created by Mohamed-Iheb FAIZA on 15/03/2018.
//  Copyright © 2018 FAIZA&LECLER. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class EnregistrerSymptomeViewController : UIViewController, UIPickerViewDelegate, UIPickerViewDataSource  {
    
    
    @IBOutlet weak var symptomeDatePicker: UIDatePicker!
    @IBOutlet weak var symptomeTypePicker: UIPickerView!
    var symptomeTypeList : [Symptome] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.seedSymptomes()
        self.loadSymptomes()
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
        return symptomeTypeList.count
    }
    
    // The data to return for the row and component (column) that's being passed in
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return symptomeTypeList[row].libelle
    }
    
    @IBAction func saveSymptome(_ sender: Any) {
        guard let appDel = UIApplication.shared.delegate as? AppDelegate else{return}
        let context = appDel.persistentContainer.viewContext
       
        let symptomeDate = symptomeDatePicker.date
        let symptomeType = symptomeTypeList[symptomeTypePicker.selectedRow(inComponent: 0)]
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        print("Enregistrement du symptome : " + symptomeType.libelle! + " a la date : "+formatter.string(from: symptomeDate))
        
        guard let entity =  NSEntityDescription.entity(forEntityName: "Date", in: context) else {fatalError("Failed to initialize Evenement entity description")}
        
        let dateToSave = Date(entity: entity, insertInto: context)
        dateToSave.date = symptomeDate as NSDate
        
        symptomeType.addToEstSignaleLe(dateToSave)
        
        do {
            try context.save()
        }
        catch let error as NSError{
            self.alertError(errorMsg : "\(error)", userInfo : "\(error.userInfo)")
        }
    }
    
    func seedSymptomes(){
        guard let appDel = UIApplication.shared.delegate as? AppDelegate else{return}
        let context = appDel.persistentContainer.viewContext
        guard let entity =  NSEntityDescription.entity(forEntityName: "Symptome", in: context) else {fatalError("Failed to initialize Evenement entity description")}
        let symptome1 = Symptome(entity: entity, insertInto: context)
        symptome1.libelle = "Symptome 1"
        let symptome2 = Symptome(entity: entity, insertInto: context)
        symptome2.libelle = "Symptome 2"
        let symptome3 = Symptome(entity: entity, insertInto: context)
        symptome3.libelle = "Symptome 3"
        do {
            try context.save()
        }
        catch let error as NSError{
            self.alertError(errorMsg : "\(error)", userInfo : "\(error.userInfo)")
        }
    }
    
    func loadSymptomes() {
        guard let appDel = UIApplication.shared.delegate as? AppDelegate else{return}
        let context = appDel.persistentContainer.viewContext
        let request : NSFetchRequest<Symptome> = Symptome.fetchRequest()
        do {
            try self.symptomeTypeList = context.fetch(request)
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
