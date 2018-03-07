//
//  ViewController.swift
//  Mon_PK_et_moi
//
//  Created by Mohamed-Iheb FAIZA on 23/02/2018.
//  Copyright © 2018 FAIZA&LECLER. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var bonjourLabel: UILabel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        // Charger la configuration
        //let conf = Config()
        //bonjourLabel?.text = "Bonjour "+conf.sexePatient+". " + conf.nomPatient
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

