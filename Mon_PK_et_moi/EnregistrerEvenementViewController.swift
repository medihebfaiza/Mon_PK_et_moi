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
    var eventTypeList : [String] = ["Diskinésie","Off","On"]
    var newEvent : Evenement?
    
    /// Is called when the view is created.
    /// - Precondition:
    /// - Parameter index: <#index description#>
    /// - Returns: <#return value description#>
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    /// Is called when the signalButton is pressed. Adds the date and event to the persistent layer.
    /// - Precondition: A date and event must have been selected in the view.
    /// - Parameter index: <#index description#>
    /// - Returns: <#return value description#>
    @IBAction func signalButton(_ sender: Any) {
        let eventDate = dateEvent.date
        let eventType = eventTypeList[event.selectedRow(inComponent: 0)]
        
        self.newEvent = Evenement(date : eventDate as NSDate,libelle :eventType)
        
        do {
            try CoreDataManager.context.save()
            DialogBoxHelper.alert(view: self, withTitle: "", andMessage: "Evenement ajouté avec succés.")
        }
        catch let error as NSError{
            DialogBoxHelper.alert(view: self, error: error)
        }
    }
    
    // The number of columns of data
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return eventTypeList.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return eventTypeList[row]
    }
}
