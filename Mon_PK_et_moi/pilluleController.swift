//
//  AjoutPilluleControler.swift
//  Mon_PK_et_moi
//
//  Created by Hugo LECLER on 09/03/2018.
//  Copyright © 2018 FAIZA&LECLER. All rights reserved.
//

import Foundation
import UIKit
import CoreData
class pilluleController: UIViewController
{
    var pilluleList : [Medicament] = []
    
    
    @IBOutlet weak var choixmedicament: UIPickerView!
    @IBOutlet weak var debutprise: UIDatePicker!
    @IBOutlet weak var finprise: UIDatePicker!
    @IBOutlet weak var heureprise: UIDatePicker!
    
    func alertError(errorMsg error : String, userInfo user: String = ""){
        let alert = UIAlertController(title : error, message : user, preferredStyle : .alert)
        let cancelAction = UIAlertAction(title : "Ok", style : .default)
        alert.addAction(cancelAction)
        present(alert,animated: true)
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // The number of rows of data
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pilluleList.count
    }
    
    // The data to return for the row and component (column) that's being passed in
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pilluleList[row].nom
    }
    
    @IBAction func validerPress(_ sender: Any) {
        
        
    }

}
