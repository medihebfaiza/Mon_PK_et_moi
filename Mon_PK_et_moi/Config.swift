//
//  Config.swift
//  Mon_PK_et_moi
//
//  Created by Hugo LECLER on 28/02/2018.
//  Copyright © 2018 FAIZA&LECLER. All rights reserved.
//

import Foundation
import CoreData

class Config{
    //var ConfigModel : ConfigModel
    var nomPatient : String
    var prenomPatient : String
    var sexePatient : String
    var dateNaissance : Date
    
    init(){
        let request : NSFetchRequest<ConfigModel> = ConfigModel.fetchRequest()
        do {
            let requestResult : [ConfigModel] = try request.execute()
            nomPatient = requestResult[0].nomPatient!
            prenomPatient = requestResult[0].prenomPatient!
            sexePatient = requestResult[0].sexePatient!
            dateNaissance = requestResult[0].dateNaissancePatient! as Date
        }
        catch _ as NSError{
            nomPatient = "Nondéfini"
            prenomPatient = "Nondéfini"
            sexePatient = "M"
            let dateFormatterGet = DateFormatter()
            dateFormatterGet.dateFormat = "yyyy-MM-dd"
            dateNaissance = dateFormatterGet.date(from: "2018-02-28")!
        }
      
    }
    
}
