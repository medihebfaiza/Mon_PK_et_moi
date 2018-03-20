//
//  AgendaViewController.swift
//  Mon_PK_et_moi
//
//  Created by Mohamed-Iheb FAIZA on 12/03/2018.
//  Copyright © 2018 FAIZA&LECLER. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class AgendaViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    
    @IBOutlet weak var eventsTable: UITableView!
    
    var rdvs : [Rendezvous] = []
 
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //self.seedEvents()
        self.loadRDVs()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.rdvs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.eventsTable.dequeueReusableCell(withIdentifier: "eventCell", for:indexPath ) as! AgendaTableViewCell
        cell.eventNameLabel.text =  "RDV avec Dr. " + (self.rdvs[indexPath.row].estdemandepar?.nom)!
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.delete){
            self.eventsTable.beginUpdates()
            if self.delete(eventWithIndex: indexPath.row){
                self.eventsTable.deleteRows(at: [indexPath], with: UITableViewRowAnimation.automatic)
            }
            self.eventsTable.endUpdates()
        }
    }
    
    
    /// Deletes an event from the persistent layer
    /// - Precondition: index must be into bound of the collection
    /// - Parameter index: index of the event to delete
    /// - Returns: true if the event is deleted with success, false if not
    func delete(eventWithIndex index: Int) -> Bool {
        let rdv = rdvs[index]
        CoreDataManager.context.delete(rdv)
        do {
            try CoreDataManager.context.save()
            self.rdvs.remove(at: index)
            return true
        }
        catch let error as NSError{
            DialogBoxHelper.alert(view: self, error: error)
            return false
        }
    }
    
    /// Insert some demo data into the Evenement entity
    func seedEvents(){
        guard let entity =  NSEntityDescription.entity(forEntityName: "Evenement", in: CoreDataManager.context) else {fatalError("Failed to initialize Evenement entity description")}
        let event = Evenement(entity: entity, insertInto: CoreDataManager.context)
        event.libelle = "Event 1"
        do {
            try CoreDataManager.context.save()
        }
        catch let error as NSError{
            DialogBoxHelper.alert(view: self, error: error)
        }
    }
    
    /// Load data from the Rendezvous entity to the rdvs table 
    func loadRDVs() {
        let request : NSFetchRequest<Rendezvous> = Rendezvous.fetchRequest()
        do {
            try self.rdvs = CoreDataManager.context.fetch(request)
        }
        catch let error as NSError{
            DialogBoxHelper.alert(view: self, error: error)
        }
    }
}
