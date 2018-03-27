//
//  ActivityPickerViewController.swift
//  Mon_PK_et_moi
//
//  Created by Hugo LECLER on 23/03/2018.
//  Copyright © 2018 FAIZA&LECLER. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class ActivityPickerViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource
{
    @IBOutlet weak var activityPicker: UIPickerView!
    var activites : [Activite] = []

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "StartActivitySegue" {
            if let controller = segue.destination as? StartActivityViewController{
                controller.activitySelected = activites[activityPicker.selectedRow(inComponent: 0)].libelle!

            }
        }
    }
    
    /// Is called when the startActivity is pressed. Sends the name of the chosen activity to the next view.
    /// - Precondition: An activity must have been selected.
    /// - Parameter index: <#index description#>
    /// - Returns: <#return value description#>
    @IBAction func startActivity(_ sender: Any) {
        self.performSegue(withIdentifier: "StartActivitySegue", sender: self)
    }

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        seedActivites()
        loadActivites()
    }
    
    func seedActivites(){
        if (CoreDataManager.entityIsEmpty(entityName : "Activite")){
            guard let entity =  NSEntityDescription.entity(forEntityName: "Activite", in: CoreDataManager.context)   else {fatalError("Failed to initialize Activite entity description")}
            let activite1 = Activite(entity: entity, insertInto: CoreDataManager.context)
            activite1.libelle = "Marche à pied"
            let activite2 = Activite(entity: entity, insertInto: CoreDataManager.context)
            activite2.libelle  = "Course"
            let activite3 = Activite(entity: entity, insertInto: CoreDataManager.context)
            activite3.libelle = "Athlétisme"
            if let error = CoreDataManager.save() {
                DialogBoxHelper.alert(view: self, error: error)
            }
        }
    }

    // The number of rows of data
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return activites.count
    }
    
    // The data to return for the row and component (column) that's being passed in
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return activites[row].libelle
    }

    func loadActivites(){
        let request : NSFetchRequest<Activite> = Activite.fetchRequest()
        do {
            try self.activites = CoreDataManager.context.fetch(request)
        }
        catch let error as NSError{
            DialogBoxHelper.alert(view: self, error: error)
        }
        activites.sort(by: {$1.libelle! > $0.libelle! })

    }
}
