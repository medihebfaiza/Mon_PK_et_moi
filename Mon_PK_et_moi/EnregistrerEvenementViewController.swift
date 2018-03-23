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
    

    func seedEvent()
    {
        if (CoreDataManager.entityIsEmpty(entityName: "Evenement"))
        {
            guard let entity =  NSEntityDescription.entity(forEntityName: "Evenement", in: CoreDataManager.context) else {fatalError("Failed to initialize Evenement entity description")}
            let evenement1 = Evenement(entity: entity, insertInto: CoreDataManager.context)
            evenement1.libelle = "Diskinésie"
            let evenement2 = Evenement(entity: entity, insertInto: CoreDataManager.context)
            evenement2.libelle = "Off"
            let evenement3 = Evenement(entity: entity, insertInto: CoreDataManager.context)
            evenement3.libelle = "On"
            
            if let error = CoreDataManager.save() {
                DialogBoxHelper.alert(view: self, error: error)
            }
            else {
                //DialogBoxHelper.alert(view: self, withTitle: "", andMessage: "Evenement ajouté avec succés.")
            }
        }
        else {
            //DialogBoxHelper.alert(view: self, withTitle: "", andMessage: "Evenement ajouté avec succés.")
        }
    }
        
        
        
    /// Is called to load the events from the persistent layer to the eventTypeList argument.
    /// - Precondition: The Evenement table must not be empty.
    /// - Returns:
    func loadEvents() {
        let request : NSFetchRequest<Evenement> = Evenement.fetchRequest()
        do {
            try self.eventTypeList = CoreDataManager.context.fetch(request)
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
