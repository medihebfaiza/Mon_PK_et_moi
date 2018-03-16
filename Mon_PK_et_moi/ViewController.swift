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
    var configbase = Configuration()
    var config : [Configuration] = []
    
    var events : [String] = ["event 1","event 2"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        config = [configbase]
        guard let appDel = UIApplication.shared.delegate as? AppDelegate else{return}
        let context = appDel.persistentContainer.viewContext
        let request : NSFetchRequest<Configuration> = Configuration.fetchRequest()
        do {
            
            try self.config = context.fetch(request)
            if(config[0].nomPatient != nil){
                bonjourLabel?.text = "Bonjour " + config[0].nomPatient! + "."
            }
            else{bonjourLabel?.text = "Nom patient inconnu."}
        }
        catch let error as NSError{
            self.alertError(errorMsg : "\(error)", userInfo : "\(error.userInfo)")
        }
        
        // Do any additional setup after loading the view, typically from a nib.
        
        //Register class for the UITableViewCell
        //self.eventsTable.register(AccueilTableViewCell.self, forCellReuseIdentifier: "eventCellAccueil")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(self.events.count)
        return self.events.count
    }
    
    func alertError(errorMsg error : String, userInfo user: String = ""){
        let alert = UIAlertController(title : error, message : user, preferredStyle : .alert)
        let cancelAction = UIAlertAction(title : "Ok", style : .default)
        alert.addAction(cancelAction)
        present(alert,animated: true)
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

}

