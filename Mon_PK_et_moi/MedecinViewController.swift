//
//  MedecinViewController.swift
//  Mon_PK_et_moi
//
//  Created by Hugo LECLER on 24/03/2018.
//  Copyright © 2018 FAIZA&LECLER. All rights reserved.
//

import Foundation
import UIKit
import CoreData


class MedecinViewController : UIViewController, UITableViewDelegate, UITableViewDataSource{
    var medecins : [Medecin] = []
    @IBOutlet weak var medecinTableView: UITableView!
    
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.medecins.count
    }

    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.delete){
            self.medecinTableView.beginUpdates()
            if self.delete(eventWithIndex: indexPath.row){
                self.medecinTableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.automatic)
            }
            self.medecinTableView.endUpdates()
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.medecinTableView.dequeueReusableCell(withIdentifier: "medecinTableCell", for:indexPath ) as! MedecinTableViewCell
        cell.medecinNameLabel.text =  "Dr. " + (self.medecins[indexPath.row].nom)!.uppercased() + " " + (self.medecins[indexPath.row].prenom)!
        cell.telephoneLabel.text = (self.medecins[indexPath.row].numTelephone)!
        return cell
    }
    
    func delete(eventWithIndex index: Int) -> Bool {
        let medecin = medecins[index]
        CoreDataManager.context.delete(medecin)
        do {
            try CoreDataManager.context.save()
            self.medecins.remove(at: index)
            return true
        }
        catch let error as NSError{
            DialogBoxHelper.alert(view: self, error: error)
            return false
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.seedMedecins()
        self.loadMedecins()
    }
    
    func loadMedecins(){
        let request : NSFetchRequest<Medecin> = Medecin.fetchRequest()
        do {
            try self.medecins = CoreDataManager.context.fetch(request)
        }
        catch let error as NSError{
            DialogBoxHelper.alert(view: self, error: error)
        }
    }
    
    func seedMedecins(){
        if (CoreDataManager.entityIsEmpty(entityName : "Medecin")){
            guard let entity =  NSEntityDescription.entity(forEntityName: "Medecin", in: CoreDataManager.context)   else {fatalError("Failed to initialize Evenement entity description")}
            let medecin1 = Medecin(entity: entity, insertInto: CoreDataManager.context)
            medecin1.nom = "jacques"
            medecin1.prenom = "toto"
            medecin1.numTelephone = "06 20 20 10 10"
            let medecin2 = Medecin(entity: entity, insertInto: CoreDataManager.context)
            medecin2.nom = "faiza"
            medecin2.prenom = "momo"
            medecin2.numTelephone = "06 20 20 10 11"
            let medecin3 = Medecin(entity: entity, insertInto: CoreDataManager.context)
            medecin3.nom = "lecler"
            medecin3.prenom = "hugo"
            medecin3.numTelephone = "06 20 20 10 12"
            
            if let error = CoreDataManager.save() {
                DialogBoxHelper.alert(view: self, error: error)
            }
        }
    }
}
