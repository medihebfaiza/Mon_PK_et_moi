//
//  HistoriqueViewController.swift
//  Mon_PK_et_moi
//
//  Created by Mohamed Iheb Faiza on 26/03/2018.
//  Copyright © 2018 FAIZA&LECLER. All rights reserved.
//

import UIKit

class HistoriqueViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var reponsesTable: UITableView!
    
    var reponses : [Reponse] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadReponses()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    // MARK: - TableView Functions

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reponses.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.reponsesTable.dequeueReusableCell(withIdentifier: "historiqueCell", for:indexPath ) as! HistoriqueTableViewCell
        cell.dateLabel.text = DateConverter.toDDmmYYYY(date : self.reponses[indexPath.row].date)
        cell.libelleReponse.text = (self.reponses[indexPath.row].libelle)
        return cell
    }
    
    /// Load data from the Rendezvous entity to the rdvs table
    func loadReponses() {
        self.reponses = ReponseDAO.fetchAll()!
    }
    
    @IBAction func deleteAllReponses(_ sender: Any) {
        for reponse in reponses{
            ReponseDAO.delete(Reponse: reponse)
        }
        do {
            try CoreDataManager.context.save()
            while (reponses.count > 0) {
                self.reponses.remove(at: 0)
            }
            reponsesTable.reloadData()
            DialogBoxHelper.alert(view: self, withTitle: "", andMessage: "Historique des réponses vidé avec succés")
        }
        catch let error as NSError{
            DialogBoxHelper.alert(view: self, error: error)
        }
    }
    
    
}
