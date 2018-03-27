//
//  JournalViewController.swift
//  Mon_PK_et_moi
//
//  Created by Mohamed-Iheb FAIZA on 27/03/2018.
//  Copyright © 2018 FAIZA&LECLER. All rights reserved.
//

import UIKit

class JournalViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var eventsTable: UITableView!
    var evenements : [Evenement] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadEvenements()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return evenements.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.eventsTable.dequeueReusableCell(withIdentifier: "eventCell", for:indexPath ) as! JournalTableViewCell
        cell.evenementLabel.text =  self.evenements[indexPath.row].libelle
        cell.dateLabel.text = DateConverter.toString(date : self.evenements[indexPath.row].date)

        return cell
    }

    /// Load data from the Rendezvous entity to the rdvs table
    func loadEvenements() {
        self.evenements = EvenementDAO.fetchAll()
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
