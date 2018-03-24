//
//  Evenement.swift
//  Mon_PK_et_moi
//
//  Created by Mohamed-Iheb FAIZA on 24/03/2018.
//  Copyright © 2018 FAIZA&LECLER. All rights reserved.
//

import Foundation

// MARK: -
/**
 Evenement type
 
 **date**: Evenement -> NSDate
 **libelle**: Evenement -> String
 */
extension Evenement{
    // MARK: -
    
    /// date of Evenement
    public var date : NSDate{
        return self.eDate!
    }
    /// libelle of Evenement
    public var libelle : String{
        return self.eLibelle!
        
    }
    
    /// text description of Evenement
    override public var description : String {
        var description = "Evenement : date = "+self.date.description
        description += ", libelle = "
        description += self.libelle
        return description
    }
    
    /// initialize a `Evenement`
    ///
    /// - Parameters:
    ///   - date: `NSDate` date of `Evenement`
    ///   - libelle:  `String` libelle of `Evenement`
    convenience init(date: NSDate, libelle: String){
        self.init(context: CoreDataManager.context)
        self.eDate = date
        self.eLibelle = libelle
    }
}
