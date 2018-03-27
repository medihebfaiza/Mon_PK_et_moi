//
//  Medicament.swift
//  Mon_PK_et_moi
//
//  Created by Mohamed-Iheb FAIZA on 27/03/2018.
//  Copyright © 2018 FAIZA&LECLER. All rights reserved.
//

import Foundation

// MARK: -
/**
 Evenement type
 
 **date**: Medicament -> NSDate
 **libelle**: Medicament -> String
 **traitements**: Medicament -> [Traitement]
 */
extension Medicament{
    // MARK: -
    
    /// date of Medicament
    public var dose : String{
        return self.mDose!
    }
    /// libelle of Medicament
    public var nom : String{
        return self.mNom!
        
    }
    
    // traitements of Medicament
    public var traitements : [Traitement]{
        return self.traitement?.allObjects as! [Traitement]
    }
    
    /// text description of Medicament
    override public var description : String {
        var description = "Medicament : dose = "+self.dose
        description += ", nom = "
        description += self.nom
        return description
    }
    
    /// initialize a `Medicament`
    ///
    /// - Parameters:
    ///   - nom:  `String` nom of `Medicament`
    ///   - dose: `String` dose of `Medicament`
    convenience init(nom: String, dose: String){
        self.init(context: CoreDataManager.context)
        self.mDose = dose
        self.mNom = nom
    }
}
