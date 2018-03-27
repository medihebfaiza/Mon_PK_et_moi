//
//  ModifCoachViewController.swift
//  Mon_PK_et_moi
//
//  Created by Hugo LECLER on 24/03/2018.
//  Copyright © 2018 FAIZA&LECLER. All rights reserved.
//

import Foundation
import UIKit
import CoreData


class ModifCoachViewController : UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    var activites : [Activite] = []
    @IBOutlet weak var activitesTableView: UITableView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadActivites()
        activitesTableView.reloadData()
    }
    
    /// Adds a new activity in the coredata
    /// - Precondition:
    /// - Parameter index: <#index description#>
    /// - Returns: <#return value description#>
    @IBAction func addAction(_ sender: Any) {
        guard let entity =  NSEntityDescription.entity(forEntityName: "Activite", in: CoreDataManager.context) else {fatalError("Failed to initialize Activite entity description")}
        let activite = Activite(entity: entity, insertInto: CoreDataManager.context)
        
        let alert = UIAlertController(title: "Nouvelle activité", message: "Ajouter une activité", preferredStyle : .alert)
        let saveAction = UIAlertAction(title : "Ajouter", style : .default)
        {
            [unowned self] action in
            guard let textfield = alert.textFields?.first,
                let nameToSave = textfield.text else {
                    return
            }
            if (nameToSave == "") {return}
            activite.libelle = nameToSave
            self.activites.append(activite)
            self.activitesTableView.reloadData()
            if let error = CoreDataManager.save() {
                DialogBoxHelper.alert(view: self, error: error)
            }
            
        }
        let cancelAction = UIAlertAction(title : "Annuler", style : .default)
        alert.addTextField()
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        present(alert, animated: true)
        
        
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.seedActivites()
        self.loadActivites()
        let request : NSFetchRequest<Activite> = Activite.fetchRequest()
        do{
            try self.activites = CoreDataManager.context.fetch(request)
        }catch let error as NSError{
            DialogBoxHelper.alert(view: self, error: error)
        }
        
    }
    
    func loadActivites() {
        let request : NSFetchRequest<Activite> = Activite.fetchRequest()
        do {
            try self.activites = CoreDataManager.context.fetch(request)
        }
        catch let error as NSError{
            DialogBoxHelper.alert(view: self, error: error)
        }
        activites.sort(by: {$1.libelle! > $0.libelle!})
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.activites.count
    }
    
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.delete){
            self.activitesTableView.beginUpdates()
            if self.delete(eventWithIndex: indexPath.row){
                self.activitesTableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.automatic)
            }
            self.activitesTableView.endUpdates()
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.activitesTableView.dequeueReusableCell(withIdentifier: "modifCoachCell", for:indexPath ) as! ModifCoachViewCell
        cell.activiteNameLabel.text = (self.activites[indexPath.row].libelle)!
        return cell
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
    
    func delete(eventWithIndex index: Int) -> Bool {
        let medecin = activites[index]
        CoreDataManager.context.delete(medecin)
        do {
            try CoreDataManager.context.save()
            self.activites.remove(at: index)
            return true
        }
        catch let error as NSError{
            DialogBoxHelper.alert(view: self, error: error)
            return false
        }
    }

    
}
