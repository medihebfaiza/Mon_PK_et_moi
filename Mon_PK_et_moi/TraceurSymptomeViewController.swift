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
    var symptomes : [Symptome]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadSymptomes()
        symptomesTable.reloadData()
    }
    
    // Dispose of any resources that can be recreated.
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return symptomes!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.symptomesTable.dequeueReusableCell(withIdentifier: "symptomeCell", for:indexPath ) as! TraceurSymptomeTableViewCell
        cell.symptomeLabel.text = self.symptomes?[indexPath.row].libelle
        return cell
    }
    
    /// Is called whenever the date in the DatePicker is changed.
    /// - Precondition: the form in the view must be complete.
    /// - Parameter index: <#index description#>
    /// - Returns: <#return value description#>
    @IBAction func dateChanged(_ sender: Any){
        loadSymptomes()
        self.symptomesTable.reloadData()
    }
    
    /// Is called to load the UneDate from the persistent layer to the dates argument.
    /// - Precondition: the Medecin table must not be empty.
    /// - Returns:
    func loadSymptomes(){
        let newDate = self.datePicker.date
        self.symptomes = SymptomeDAO.search(forDate : newDate as NSDate)
    }
}
