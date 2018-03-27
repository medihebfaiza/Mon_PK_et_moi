//
//  Configuration.swift
//  Mon_PK_et_moi
//
//  Created by Mohamed-Iheb FAIZA on 27/03/2018.
//  Copyright © 2018 FAIZA&LECLER. All rights reserved.
//

import Foundation

// MARK: -
/**
 Configuration type
 
 **nom**: Configuration -> String
 **prenom**: Configuration -> String
 **dateNaissance**: Configuration -> NSDate
 **civilite**: Configuration -> String
 */
extension Configuration{
    // MARK: -
    
    /// nom of Configuration
    public var nom : String{
        set {
            self.cNom = newValue
        }
        get {
          return self.cNom!
        }
    }
    /// prenom of Configuration
    public var prenom  : String{
        set {
            self.cPrenom = newValue
        }
        get {
            return self.cPrenom!
        }
    }
    /// dateNaissance of Configuration
    public var dateNaissance : String{
        set {
            self.cDateNaissance = newValue
        }
        get {
            return self.cDateNaissance!
        }
    }
    /// civilite of Configuration
    public var civilite : String{
        set {
            self.cCivilite = newValue
        }
        get {
            return self.cCivilite!
        }
    }
    
    /// text description of Configuration
    override public var description : String {
        var description = "Configuration : nom = "+self.nom
        description += ", prenom = "
        description += self.prenom
        description += ", dateNaissance = "
        description += self.dateNaissance
        description += ", civilite = "
        description += self.civilite
        return description
    }
    
    /// initialize a `Configuration`
    ///
    /// - Parameters:
    ///   - nom: `String` nom of `Configuration`
    ///   - prenom : `String` prenom of `Configuration`
    ///   - dateNaissance:  `String` dateNaissance of `Configuration`
    ///   - civilite:  `String` civilite of `Configuration`
    convenience init(nom: String, prenom: String, dateNaissance: String, civilite: String){
        self.init(context: CoreDataManager.context)
        self.cNom = nom
        self.cPrenom  = prenom
        self.cDateNaissance = dateNaissance
        self.cCivilite = civilite
    }
}
