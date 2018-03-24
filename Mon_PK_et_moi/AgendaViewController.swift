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
    @IBOutlet weak var filterDatePicker: UIDatePicker!
    
    var rdvs : [Rendezvous] = []
 
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadRDVs()
        filterDatePicker.addTarget(self, action: #selector(AgendaViewController.datePickerValueChanged), for: UIControlEvents.valueChanged)
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
        cell.medecinLabel.text =  (self.rdvs[indexPath.row].estdemandepar?.nom)!
        cell.heureRDVLabel.text = DateConverter.toHHmm(date : self.rdvs[indexPath.row].rDate!)
        if (self.rdvs[indexPath.row].rSemestriel){
            cell.semestrielLabel.text = "Semestriel"
        }
        else {
            cell.semestrielLabel.text = "Non semestriel"
        }
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
    
    /// Load data from the Rendezvous entity to the rdvs table 
    func loadRDVs() {
        self.rdvs = RendezvousDAO.search(forDate: filterDatePicker.date as NSDate)!
        //self.rdvs = RendezvousDAO.fetchAll()!
    }
    
    func datePickerValueChanged(){
        loadRDVs()
        self.eventsTable.reloadData()
    }
    
}
