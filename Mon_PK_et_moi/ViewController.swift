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
    var config : Configuration?
    var prises : [Traitement] = []
    var rdvs : [Rendezvous] = []
    var fuse : [FuseTables] = []
    var events : [String] = ["event 1","event 2"]
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getPatientLabel()
        loadSoon()
        eventsTable.reloadData()
    }
    
    // Setup after loading the view
    func getPatientLabel() {
        self.config = ConfigurationDAO.fetchConfig()
        if (self.config == nil){
            bonjourLabel?.text = "Patient inconnu."
        }
        else if(self.config?.nom != nil){
            bonjourLabel?.text = "Bonjour " + (config?.nom)! + "."
        }
        else{
            bonjourLabel?.text = "Nom patient inconnu."
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.fuse.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.eventsTable.dequeueReusableCell(withIdentifier: "eventCellAccueil", for:indexPath ) as! AccueilTableViewCell
        if (cell.eventNameLabel == nil){
            print("Error tableviewcell empty")
        }
        else{
            cell.eventNameLabel?.text = self.fuse[indexPath.row].content
            let lheure : String? = DateConverter.toHHmm(date: self.fuse[indexPath.row].heure! as NSDate)
            cell.heureNameLabel?.text = lheure
        }
        return cell
    }
    

    func loadSoon(){
        fuse = []
        let request1 : NSFetchRequest<Traitement> = Traitement.fetchRequest()
        do {
            try self.prises = CoreDataManager.context.fetch(request1)
        }
        catch let error as NSError{
            DialogBoxHelper.alert(view: self, error: error)
        }
        let request2 : NSFetchRequest<Rendezvous> = Rendezvous.fetchRequest()
        do {
            try self.rdvs = CoreDataManager.context.fetch(request2)
        }
        catch let error as NSError{
            DialogBoxHelper.alert(view: self, error: error)
        }
        if(!CoreDataManager.entityIsEmpty(entityName: "Traitement")){
            for i in 0...prises.count - 1 {
                fuse.append(FuseTables(contenu : (prises[i].medicament?.nom)! + " " + (prises[i].medicament?.dose)!, lheure: prises[i].heure! as Date))
            
            }
        }
        if(!CoreDataManager.entityIsEmpty(entityName: "Rendezvous")){
            for i in 0 ... rdvs.count - 1  {
                fuse.append(FuseTables(contenu : "Dr. " + (rdvs[i].estdemandepar?.nom)!, lheure: rdvs[i].rDate! as Date))
            }
        }
        fuse.sort(by: {$1.heure! as Date > $0.heure! as Date})
    }
}

