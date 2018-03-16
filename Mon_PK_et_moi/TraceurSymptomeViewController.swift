//
//  TraceurSymptomeViewController.swift
//  Mon_PK_et_moi
//
//  Created by Mohamed-Iheb FAIZA on 15/03/2018.
//  Copyright © 2018 FAIZA&LECLER. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class TraceurSymptomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var symptomesTable: UITableView!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    var dates : [Date] = []
    var symptomes : [Symptome] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return symptomes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.symptomesTable.dequeueReusableCell(withIdentifier: "symptomeCell", for:indexPath ) as! TraceurSymptomeTableViewCell
        cell.symptomeLabel.text = self.symptomes[indexPath.row].libelle
        return cell
    }
    
    @IBAction func dateChanged(_ sender: Any){
        loadSymptomes()
    }
    
    func loadSymptomes(){
        let newDate = self.datePicker.date
        guard let appDel = UIApplication.shared.delegate as? AppDelegate else{return}
        let context = appDel.persistentContainer.viewContext
        let request : NSFetchRequest<Date> = Date.fetchRequest()
        request.predicate = NSPredicate(format: "date == %@", newDate as CVarArg)
        do {
            try self.dates = context.fetch(request)
            //TODO : charger les symptomes signaler à la date choisie
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
