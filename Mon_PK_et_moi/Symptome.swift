//
//  Symptome.swift
//  Mon_PK_et_moi
//
//  Created by Mohamed-Iheb FAIZA on 27/03/2018.
//  Copyright © 2018 FAIZA&LECLER. All rights reserved.
//

import Foundation

// MARK: -
/**
 Symptome type
 
 **libelle**: Symptome -> String
 **dates**: Symptome -> [NSDate]
 */
extension Symptome{
    // MARK: -
    
    /// date of Symptome
    public var dates : [NSDate]{
        let lesDates = self.estSignaleLe?.allObjects as! [UneDate]
        var resultat : [NSDate] = []
        for date in lesDates {
            resultat.append(date.date!)
        }
        return resultat
    }
    /// libelle of Symptome
    public var libelle : String?{
        return self.sLibelle
        
    }
    
    /// text description of Symptome
    override public var description : String{
        let description = "Symptome : libelle = " + self.libelle!
        return description
    }
    
    /// initialize a `Symptome`
    ///
    /// - Parameters:
    ///   - libelle:  `String` libelle of `Symptome`
    convenience init(libelle: String){
        self.init(context: CoreDataManager.context)
        self.sLibelle = libelle
    }
}
