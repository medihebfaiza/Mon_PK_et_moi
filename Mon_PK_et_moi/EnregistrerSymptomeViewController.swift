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
        self.seedSymptomes()
        self.loadSymptomes()
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
        return symptomeTypeList.count
    }
    
    // The data to return for the row and component (column) that's being passed in
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return symptomeTypeList[row].libelle
    }
    
    /// Is called when the signalButton is pressed. Adds the date and symptome to the persistent layer.
    /// - Precondition: A date and symptome must have been selected in the view.
    /// - Parameter <#index description#>
    /// - Returns: <#return value description#>
    @IBAction func saveSymptome(_ sender: Any) {
        let symptomeDate = symptomeDatePicker.date
        let symptomeType = symptomeTypeList[symptomeTypePicker.selectedRow(inComponent: 0)]
        
        guard let entity =  NSEntityDescription.entity(forEntityName: "UneDate", in: CoreDataManager.context) else {fatalError("Failed to initialize Evenement entity description")}
        
        let dateToSave = UneDate(entity: entity, insertInto: CoreDataManager.context)
        dateToSave.date = symptomeDate as NSDate
        
        symptomeType.addToEstSignaleLe(dateToSave)
        
        if let error = CoreDataManager.save() {
            DialogBoxHelper.alert(view: self, error: error)
        }
        else {
            DialogBoxHelper.alert(view: self, withTitle: "", andMessage: "Symptome enregistré avec succés.")
        }
    }
    
    /// Is called when the view is loaded, adds in the picker the symptomes
    /// - Precondition:
    /// - Returns:
    func seedSymptomes(){
        if (CoreDataManager.entityIsEmpty(entityName: "Symptome")){
            guard let entity =  NSEntityDescription.entity(forEntityName: "Symptome", in: CoreDataManager.context) else     {fatalError("Failed to initialize Evenement entity description")}
            let symptome1 = Symptome(entity: entity, insertInto: CoreDataManager.context)
            symptome1.libelle = "Somnolence"
            let symptome2 = Symptome(entity: entity, insertInto: CoreDataManager.context)
            symptome2.libelle = "Chute"
            let symptome3 = Symptome(entity: entity, insertInto: CoreDataManager.context)
            symptome3.libelle = "Hallucination"
            let symptome4 = Symptome(entity: entity, insertInto: CoreDataManager.context)
            symptome4.libelle = "Prise de dispersible"
            let symptome5 = Symptome(entity: entity, insertInto: CoreDataManager.context)
            symptome5.libelle = "Clic / bolus d’Apokinon"
            do {
                try CoreDataManager.context.save()
            }
            catch let error as NSError{
                DialogBoxHelper.alert(view: self, error: error)
            }
        }
    }
    /// Is called to load the symptome from the persistent layer to the symptomeTypeList argument.
    /// - Precondition: The Symptome table must not be empty.
    /// - Returns:
    func loadSymptomes() {
        guard let appDel = UIApplication.shared.delegate as? AppDelegate else{return}
        let context = appDel.persistentContainer.viewContext
        let request : NSFetchRequest<Symptome> = Symptome.fetchRequest()
        do {
            try self.symptomeTypeList = context.fetch(request)
        }
        catch let error as NSError{
            DialogBoxHelper.alert(view: self, error: error)
        }
    }
}
