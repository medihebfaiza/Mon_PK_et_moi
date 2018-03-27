//
//  ViewController.swift
//  Mon_PK_et_moi
//
//  Created by Mohamed-Iheb FAIZA on 23/02/2018.
//  Copyright © 2018 FAIZA&LECLER. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var bonjourLabel: UILabel?
    @IBOutlet weak var eventsTable: UITableView!
    var config : [Configuration] = []
    var prises : [Traitement] = []
    var rdvs : [Rendezvous] = []
    var events : [String] = ["event 1","event 2"]
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getPatientLabel()
        eventsTable.reloadData()
    }
    
    // Setup after loading the view
    override func viewDidLoad() {
        super.viewDidLoad()
        getPatientLabel()
        loadSoon()
        
        // Do any additional setup after loading the view, typically from a nib.
        
        //Register class for the UITableViewCell
        //self.eventsTable.register(AccueilTableViewCell.self, forCellReuseIdentifier: "eventCellAccueil")
    }

    func getPatientLabel(){
        do {
            let request : NSFetchRequest<Configuration> = Configuration.fetchRequest()
            try self.config = CoreDataManager.context.fetch(request)
            if (self.config == []){
                bonjourLabel?.text = "Patient inconnu."
            }
            else if(config[0].nom != nil){
                bonjourLabel?.text = "Bonjour " + config[0].nom! + "."
            }
            else{bonjourLabel?.text = "Nom patient inconnu."
            }
        }
        catch let error as NSError{
            DialogBoxHelper.alert(view: self, error: error)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.events.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.eventsTable.dequeueReusableCell(withIdentifier: "eventCellAccueil", for:indexPath ) as! AccueilTableViewCell
        if (cell.eventNameLabel == nil){
            print("Error tableviewcell empty")
        }
        else{
            cell.eventNameLabel?.text = self.events[indexPath.row]}
        return cell
    }
    
    func seedSoon(){
        if (CoreDataManager.entityIsEmpty(entityName : "Medecin")){
            guard let entity =  NSEntityDescription.entity(forEntityName: "Medecin", in: CoreDataManager.context)   else {fatalError("Failed to initialize Medecin entity description")}
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
    
    func loadSoon(){
        
    }
}

