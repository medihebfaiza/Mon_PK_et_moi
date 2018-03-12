//
//  AjoutPilluleControler.swift
//  Mon_PK_et_moi
//
//  Created by Hugo LECLER on 09/03/2018.
//  Copyright © 2018 FAIZA&LECLER. All rights reserved.
//

import Foundation
import UIKit

class pilluleController: UIViewController
{
    @IBAction func buttonajoutpillule(_ sender: Any)
    {
        let alert = UIAlertController(title : "Ajouter une heure", message : "Ajouter heure",preferredStyle: .alert)
        let saveAction = UIAlertAction(title : "Ajouter", style : .default)
        {
            [unowned self] action in
            guard let textField = alert.textFields?.first,
                let hourToSave = textField.text else
                {
                    return
                }
        }
        //self.names.append(nameToSave)
        //self.pilluleTableView.reloadData()
        let cancelAction = UIAlertAction (title : "Annuler", style: .default)
        alert.addTextField()
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true)
    }
    

}
