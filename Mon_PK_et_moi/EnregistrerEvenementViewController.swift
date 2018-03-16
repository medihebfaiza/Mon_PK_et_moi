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
    
    @IBAction func signalButton(_ sender: Any) {
        guard let appDel = UIApplication.shared.delegate as? AppDelegate else{return}
        let context = appDel.persistentContainer.viewContext
        
        let eventDate = dateEvent.date
        let eventType = eventTypeList[event.selectedRow(inComponent: 0)]
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        print("Enregistrement de l'évènement : " + eventType.libelle! + " a la date : "+formatter.string(from: eventDate))
        
        guard let entity =  NSEntityDescription.entity(forEntityName: "Date", in: context) else {fatalError("Failed to initialize Evenement entity description")}
        
        let dateToSave = Date(entity: entity, insertInto: context)
        dateToSave.date = eventDate as NSDate
        
        eventType.addToEventDate(dateToSave)
        
        do {
            try context.save()
        }
        catch let error as NSError{
            self.alertError(errorMsg : "\(error)", userInfo : "\(error.userInfo)")
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.seedEvent()
        self.loadEvents()
    }
    func seedEvent(){
        guard let appDel = UIApplication.shared.delegate as? AppDelegate else{return}
        let context = appDel.persistentContainer.viewContext
        guard let entity =  NSEntityDescription.entity(forEntityName: "Evenement", in: context) else {fatalError("Failed to initialize Evenement entity description")}
        let evenement1 = Evenement(entity: entity, insertInto: context)
        evenement1.libelle = "Evenement 1"
        let evenement2 = Evenement(entity: entity, insertInto: context)
        evenement2.libelle = "Evenement 2"
        let evenement3 = Evenement(entity: entity, insertInto: context)
        evenement3.libelle = "Evenement 3"
        do {
            try context.save()
        }
        catch let error as NSError{
            self.alertError(errorMsg : "\(error)", userInfo : "\(error.userInfo)")
        }
    }
    func loadEvents() {
        guard let appDel = UIApplication.shared.delegate as? AppDelegate else{return}
        let context = appDel.persistentContainer.viewContext
        let request : NSFetchRequest<Evenement> = Evenement.fetchRequest()
        do {
            try self.eventTypeList = context.fetch(request)
        }
        catch let error as NSError{
            self.alertError(errorMsg : "\(error)", userInfo : "\(error.userInfo)")
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
    

    func alertError(errorMsg error : String, userInfo user: String = ""){
        let alert = UIAlertController(title : error, message : user, preferredStyle : .alert)
        let cancelAction = UIAlertAction(title : "Ok", style : .default)
        alert.addAction(cancelAction)
        present(alert,animated: true)
    }
}
