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
    
    var events : [Evenement] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //self.seedEvents()
        self.loadEvents()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.events.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.eventsTable.dequeueReusableCell(withIdentifier: "eventCell", for:indexPath ) as! AgendaTableViewCell
        cell.eventNameLabel.text = self.events[indexPath.row].libelle
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
    
    
    /// <#Description#>
    /// - Precondition: index must be into bound of the collection
    /// - Parameter index: <#index description#>
    /// - Returns: <#return value description#>
    func delete(eventWithIndex index: Int) -> Bool {
        guard let appDel = UIApplication.shared.delegate as? AppDelegate else{return false}
        let context = appDel.persistentContainer.viewContext
        let event = events[index]
        context.delete(event)
        do {
            try context.save()
            self.events.remove(at: index)
            return true
        }
        catch let error as NSError{
            self.alertError(errorMsg : "\(error)", userInfo : "\(error.userInfo)")
            return false
        }
    }
    
    func seedEvents(){
        guard let appDel = UIApplication.shared.delegate as? AppDelegate else{return}
        let context = appDel.persistentContainer.viewContext
        guard let entity =  NSEntityDescription.entity(forEntityName: "Evenement", in: context) else {fatalError("Failed to initialize Evenement entity description")}
        let event = Evenement(entity: entity, insertInto: context)
        event.libelle = "Event 1"
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
            try self.events = context.fetch(request)
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
