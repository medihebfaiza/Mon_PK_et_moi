//
//  Reponse.swift
//  Mon_PK_et_moi
//
//  Created by Mohamed Iheb Faiza on 26/03/2018.
//  Copyright © 2018 FAIZA&LECLER. All rights reserved.
//

import Foundation

// MARK: -
/**
 Reponse type
 
 **date**: Reponse -> NSDate
 **libelle**: Reponse -> String
 */
extension Reponse{
    // MARK: -
    
    /// date of Reponse
    public var date : NSDate{
        return self.rDate!
    }
    /// libelle of Reponse
    public var libelle : String{
        return self.rLibelle!
        
    }
    
    /// text description of Reponse
    override public var description : String {
        var description = "Reponse : date = "+self.date.description
        description += ", libelle = "
        description += self.libelle
        return description
    }
    
    /// initialize a `Reponse`
    ///
    /// - Parameters:
    ///   - date: `NSDate` date of `Reponse`
    ///   - libelle:  `String` libelle of `Reponse`
    convenience init(date: NSDate, libelle: String){
        self.init(context: CoreDataManager.context)
        self.rDate = date
        self.rLibelle = libelle
    }
}
