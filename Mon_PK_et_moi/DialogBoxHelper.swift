//
//  DialogBoxHelper.swift
//  Mon_PK_et_moi
//
//  Created by Mohamed-Iheb FAIZA on 20/03/2018.
//  Copyright © 2018 FAIZA&LECLER. All rights reserved.
//

import Foundation
import UIKit

class DialogBoxHelper{
    
    /// Utility method that creates an alert popup with the designated arguments.
    /// - Precondition:
    /// - Parameter error: the title of the alert
    /// - Parameter user: the subtitle of the alert
    /// - Returns: <#return value description#>
    class func alert(view: UIViewController, withTitle title: String, andMessage msg: String = ""){
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Ok",
                                         style: .default)
        alert.addAction(cancelAction)
        view.present(alert,animated: true)
    }
    
    class func alert(view: UIViewController, error: NSError) {
        self.alert(view: view, withTitle: "\(error)", andMessage: "\(error.userInfo)")
    }
    
}
