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


    @IBOutlet weak var pillulePicker: UIPickerView!
    @IBOutlet weak var prisesTableView: UITableView!

    var prises : [Traitement] = []
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.prises.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.prisesTableView.dequeueReusableCell(withIdentifier: "PillulierTableViewCell", for:indexPath ) as! PillulierTableViewCell
        cell.pilluleNameLabel.text =  (self.prises[indexPath.row].medicament?.nom)! + " " + (self.prises[indexPath.row].medicament?.dose)! + " à " /*+ (self.prises[indexPath.row].heure?[i].heure)!*/
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
        // Do any additional setup after loading the view, typically from a nib.
        
        //self.seedEvents()
        self.loadPrises()
}

    func loadPrises(){
        let request : NSFetchRequest<Traitement> = Traitement.fetchRequest()
            do {
                try self.prises = CoreDataManager.context.fetch(request)
            }
            catch let error as NSError{
                DialogBoxHelper.alert(view: self, error: error)
        }
    }
}
