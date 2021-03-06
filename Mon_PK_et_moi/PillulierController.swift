//
//  PillulierController.swift
//  Mon_PK_et_moi
//
//  Created by Hugo LECLER on 21/03/2018.
//  Copyright © 2018 FAIZA&LECLER. All rights reserved.
//

import Foundation
import UIKit
import CoreData


class PillulierController : UIViewController, UITableViewDelegate, UITableViewDataSource {


    @IBOutlet weak var prisesTableView: UITableView!
    var toutesprises : [Traitement] = []
    var prises : [Traitement] = []
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.prises.count
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadPrises()
        prisesTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.prisesTableView.dequeueReusableCell(withIdentifier: "PillulierTableViewCell", for:indexPath ) as! PillulierTableViewCell
        cell.pilluleNameLabel.text =  (self.prises[indexPath.row].medicament?.nom)! + " " + (self.prises[indexPath.row].medicament?.dose)!
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        let heure1 = (self.prises[indexPath.row].heure)
        if (heure1 != nil){
        let durationText = formatter.string(for: heure1!)
        cell.pilluleHeureLabel.text = durationText
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.delete){
            self.prisesTableView.beginUpdates()
            if self.delete(eventWithIndex: indexPath.row){
                self.prisesTableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.automatic)
            }
            self.prisesTableView.endUpdates()
        }
    }

    func delete(eventWithIndex index: Int) -> Bool {
        let prise = prises[index]
        CoreDataManager.context.delete(prise)
        do {
            try CoreDataManager.context.save()
            self.prises.remove(at: index)
            return true
        }
        catch let error as NSError{
            DialogBoxHelper.alert(view: self, error: error)
            return false
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadPrises()
}
    /// Is called to load the Traitement from the persistent layer to the prises argument.
    /// - Precondition: the Traitement table must not be empty.
    /// - Returns:
    func loadPrises(){
        let request : NSFetchRequest<Traitement> = Traitement.fetchRequest()
            do {
                try self.toutesprises = CoreDataManager.context.fetch(request)
            }
            catch let error as NSError{
                DialogBoxHelper.alert(view: self, error: error)
        }
        if (!CoreDataManager.entityIsEmpty(entityName: "Traitement"))
        {
            for i in 0...toutesprises.count-1
            {
                if ((toutesprises[i].dateDeDebut! as Date) <= Date()) && ((toutesprises[i].dateDeFin! as Date) >= Date())
                {
                    self.prises.append(toutesprises[i])
                }
            }
        prises.sort(by:{$1.heure! as Date > $0.heure! as Date})
        }
    }
}
