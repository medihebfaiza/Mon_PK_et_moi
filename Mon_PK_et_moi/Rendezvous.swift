//
//  Rendezvous.swift
//  Mon_PK_et_moi
//
//  Created by Mohamed-Iheb FAIZA on 23/03/2018.
//  Copyright © 2018 FAIZA&LECLER. All rights reserved.
//

import Foundation

// MARK: -
/**
 Rendezvous type
 
 **date**: Rendezvous -> NSDate
 **semestriel**: Rendezvous -> Boolean
 **medecin**: Rendezvous -> Medecin
 */
extension Rendezvous{
    // MARK: -
    
    /// date of Rendezvous
    public var date : NSDate{
        return self.rDate!
    }
    /// is Rendezvous semestrial
    public var semestriel  : Bool{
        return self.rSemestriel
    }
    /// medecin of Rendezvous
    public var medecin : Medecin{
        return self.estdemandepar!
       
    }
    
    /// text description of Rendezvous
    override public var description : String {
        var description = "Rendezvous : date = "+self.date.description
        description += ", semestriel = "
        description += self.semestriel.description
        description += ", medecin = "
        description += self.medecin.description
        return description
    }
    
    /// initialize a `Rendezvous`
    ///
    /// - Parameters:
    ///   - date: `NSDate` date of `Rendezvous`
    ///   - medecin:  `Medecin` medecin of `Rendezvous`
    convenience init(date: NSDate, medecin: Medecin){
        self.init(context: CoreDataManager.context)
        self.rDate = date
        self.estdemandepar = medecin
    }
    
    /// initialize a `Rendezvous`
    ///
    /// - Parameters:
    ///   - date: `NSDate` date of `Rendezvous`
    ///   - semestriel : `Bool` semestriel of `Rendezvous`
    ///   - medecin:  `Medecin` medecin of `Rendezvous`
    convenience init(date: NSDate, semestriel: Bool, medecin: Medecin){
        self.init(context: CoreDataManager.context)
        self.rDate = date
        self.rSemestriel  = semestriel
        self.estdemandepar = medecin
    }
}
