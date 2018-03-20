//
//  EnregistrerEvenementViewController.swift
//  Mon_PK_et_moi
//
//  Created by Hugo LECLER on 16/03/2018.
//  Copyright © 2018 FAIZA&LECLER. All rights reserved.
//

import Foundation

import UIKit
import CoreData

class EnregistrerEvenementViewController : UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var dateEvent: UIDatePicker!
    @IBOutlet weak var event: UIPickerView!
    var eventTypeList : [Evenement] = []

    /// Is called when the signalButton is pressed. Adds the date and event to the persistent layer.
    /// - Precondition: A date and event must have been selected in the view.
    /// - Parameter index: <#index description#>
    /// - Returns: <#return value description#>
    @IBAction func signalButton(_ sender: Any) {
 
        let eventDate = dateEvent.date
        let eventType = eventTypeList[event.selectedRow(inComponent: 0)]
        
        guard let entity =  NSEntityDescription.entity(forEntityName: "Date", in: CoreDataManager.context)
            else {fatalError("Failed to initialize Evenement entity description")
        }
        
        let dateToSave = Date(entity: entity, insertInto: CoreDataManager.context)
        dateToSave.date = eventDate as NSDate
        
        eventType.addToEventDate(dateToSave)
        
        do {
            try CoreDataManager.context.save()
        }
        catch let error as NSError{
            DialogBoxHelper.alert(view: self, error: error)
        }
        
    }
    /// Is called when the view is created.
    /// - Precondition:
    /// - Parameter index: <#index description#>
    /// - Returns: <#return value description#>
    override func viewDidLoad() {
        super.viewDidLoad()
        self.seedEvent()
        self.loadEvents()
    }
    
    func entityIsEmpty() -> Bool
    {
        
        guard let appDel = UIApplication.shared.delegate as? AppDelegate else{return false}
        let context = appDel.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Evenement")
        guard NSEntityDescription.entity(forEntityName: "Evenement", in: context) != nil else {fatalError("Failed to initialize Evenement entity description")}
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
    func seedEvent(){
        if (entityIsEmpty()){
            guard let appDel = UIApplication.shared.delegate as? AppDelegate else{return}
            let context = appDel.persistentContainer.viewContext
            guard let entity =  NSEntityDescription.entity(forEntityName: "Evenement", in: context) else {fatalError("Failed to initialize Evenement entity description")}
            let evenement1 = Evenement(entity: entity, insertInto: context)
            evenement1.libelle = "Diskinésie"
            let evenement2 = Evenement(entity: entity, insertInto: context)
            evenement2.libelle = "Off"
            let evenement3 = Evenement(entity: entity, insertInto: context)
            evenement3.libelle = "On"
            do {
                try context.save()
            }
            catch let error as NSError{
                self.alertError(errorMsg : "\(error)", userInfo : "\(error.userInfo)")
            }
        }
        else {
            DialogBoxHelper.alert(view: self, withTitle: "", andMessage: "Rendez-vous ajouté avec succés.")
        }
    }
        
        
        
    /// Is called to load the events from the persistent layer to the eventTypeList argument.
    /// - Precondition: The Evenement table must not be empty.
    /// - Returns:
    func loadEvents() {
        guard let appDel = UIApplication.shared.delegate as? AppDelegate else{return}
        let context = appDel.persistentContainer.viewContext
        let request : NSFetchRequest<Evenement> = Evenement.fetchRequest()
        do {
            try self.eventTypeList = context.fetch(request)
        }
        catch let error as NSError{
            DialogBoxHelper.alert(view: self, error: error)
        }
        
    }
    
    // The number of columns of data
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // The number of rows of data
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return eventTypeList.count
    }
    
    // The data to return for the row and component (column) that's being passed in
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return eventTypeList[row].libelle
    }
}
