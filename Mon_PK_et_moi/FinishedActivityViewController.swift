//
//  FinishedActivityViewController.swift
//  Mon_PK_et_moi
//
//  Created by Hugo LECLER on 23/03/2018.
//  Copyright © 2018 FAIZA&LECLER. All rights reserved.
//

import Foundation
import UIKit


class FinishedActivityViewController: UIViewController{

    var activitySelected : String = ""
    @IBOutlet weak var activityName: UILabel!
    @IBAction func doneButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    };
    override func viewDidLoad() {
        super.viewDidLoad()
        activityName.text = activitySelected
    }
}


