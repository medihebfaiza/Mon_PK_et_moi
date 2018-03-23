//
//  ActivityPickerViewController.swift
//  Mon_PK_et_moi
//
//  Created by Hugo LECLER on 23/03/2018.
//  Copyright © 2018 FAIZA&LECLER. All rights reserved.
//

import Foundation
import UIKit


class ActivityPickerViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource
{
    @IBOutlet weak var activityPicker: UIPickerView!
    var activites : [String] = ["Marche à pied", "Course", "Athlétisme"]
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "StartActivitySegue" {
            if let controller = segue.destination as? StartActivityViewController{
                controller.activitySelected = activites[activityPicker.selectedRow(inComponent: 0)]

            }
        }
    }
    @IBAction func startActivity(_ sender: Any) {
        self.performSegue(withIdentifier: "StartActivitySegue", sender: self)
    }

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // The number of rows of data
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return activites.count
    }
    
    // The data to return for the row and component (column) that's being passed in
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return activites[row]
    }

}
