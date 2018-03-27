//
//  Medecin.swift
//  Mon_PK_et_moi
//
//  Created by Mohamed-Iheb FAIZA on 27/03/2018.
//  Copyright © 2018 FAIZA&LECLER. All rights reserved.
//

import Foundation

// MARK: -
/**
 Medecin type
 
 **nom**: Medecin -> String
 **prenom**: Medecin -> String
 **numTelephone**: Medecin -> String
 **adresseEmail**: Medecin -> String
 */
extension Medecin{
    // MARK: -
    
    /// nom of Medecin
    public var nom : String{
        return self.mNom!
    }
    /// prenom of Medecin
    public var prenom  : String{
        return self.mPrenom!
    }
    /// numTelephone of Medecin
    public var numTelephone : String?{
        return self.mNumTelephone!
        
    }
    /// adresseEmail of Medecin
    public var adresseEmail : String?{
        return self.mAdresseEmail!
        
    }
    
    /// text description of Medecin
    override public var description : String {
        var description = "Medecin : nom = "+self.nom
        description += ", prenom = "
        description += self.prenom
        if self.numTelephone != nil {
            description += ", numTelephone = "
            description += self.numTelephone!
        }
        if self.adresseEmail != nil {
            description += ", adresseEmail = "
            description += self.adresseEmail!
        }
        return description
    }
    
    /// initialize a `Medecin`
    ///
    /// - Parameters:
    ///   - nom: `String` nom of `Medecin`
    ///   - prenom:  `String` prenom of `Medecin`
    convenience init(nom: String, prenom: String){
        self.init(context: CoreDataManager.context)
        self.mNom = nom
        self.mPrenom = prenom
    }
    
    /// initialize a `Medecin`
    ///
    /// - Parameters:
    ///   - nom: `String` nom of `Medecin`
    ///   - prenom:  `String` prenom of `Medecin`
    ///   - numTelephone:  `String` numTelephone of `Medecin`
    convenience init(nom: String, prenom: String, numTelephone: String){
        self.init(context: CoreDataManager.context)
        self.mNom = nom
        self.mPrenom = prenom
        self.mNumTelephone = numTelephone
    }
    
    /// initialize a `Medecin`
    ///
    /// - Parameters:
    ///   - nom: `String` nom of `Medecin`
    ///   - prenom : `String` prenom of `Medecin`
    ///   - numTelephone:  `String` numTelephone of `Medecin`
    ///   - adresseEmail:  `String` adresseEmail of `Medecin`
    convenience init(nom: String, prenom: String, numTelephone: String, adresseEmail: String){
        self.init(context: CoreDataManager.context)
        self.mNom = nom
        self.mPrenom  = prenom
        self.mNumTelephone = numTelephone
        self.mAdresseEmail = adresseEmail
    }
}
