//
//  ConfigurationDAO.swift
//  Mon_PK_et_moi
//
//  Created by Mohamed-Iheb FAIZA on 22/03/2018.
//  Copyright © 2018 FAIZA&LECLER. All rights reserved.
//

import Foundation
import CoreData

class ConfigurationDAO{
    static let request : NSFetchRequest<Configuration> = Configuration.fetchRequest()
    
    static func save() -> NSError? {
        return CoreDataManager.save()
    }
    
    static func delete(Configuration: Configuration){
        CoreDataManager.context.delete(Configuration)
    }
    
    static func fetchAll() -> [Configuration]?{
        self.request.predicate = nil
        do{
            return try CoreDataManager.context.fetch(self.request)
        }
        catch{
            return nil
        }
    }
    
    static func fetchConfig() -> Configuration? {
        self.request.predicate = nil
        do{
            let config = try CoreDataManager.context.fetch(self.request)
            if (config.count == 0){
                return nil
            }
            else {
                return config[0]
            }
        }
        catch{
            return nil
        }
    }
    
    /// number of elements
    static var count: Int{
        self.request.predicate = nil
        do {
            return try CoreDataManager.context.count(for: self.request)
        }
        catch let error as NSError{
            fatalError(error.description)
        }
    }
    
    static private func createConfiguration() -> Configuration{
        return Configuration(context: CoreDataManager.context)
    }
    
    static func createConfiguration(forNom nom: String, prenom: String, dateNaissance: String, civilite: String) -> Configuration{
        let dao             = self.createConfiguration()
        dao.cNom             = nom
        dao.cPrenom          = prenom
        dao.cDateNaissance   = dateNaissance
        dao.cCivilite        = civilite
        return dao
    }

    
    static func createConfiguration(forNom nom: String, prenom: String, dateNaissance: String?, civilite: String?) -> Configuration{
        let dao             = self.createConfiguration()
        dao.cNom             = nom
        dao.cPrenom          = prenom
        dao.cDateNaissance   = dateNaissance
        dao.cCivilite        = civilite
        return dao
    }

    static func count(forNom nom: String) -> Int{
        self.request.predicate = NSPredicate(format: "cNom == %@", nom)
        do{
            return try CoreDataManager.context.count(for: self.request)
        }
        catch let error as NSError{
            fatalError(error.description)
        }
    }
    
    static func search(forNom nom: String) -> [Configuration]?{
        self.request.predicate = NSPredicate(format: "cNom == %@", nom)
        do{
            let result = try CoreDataManager.context.fetch(request) as [Configuration]
            guard result.count != 0 else { return nil }
            return result
        }
        catch{
            return nil
        }
    }
    
    static func count (forPrenom prenom: String) -> Int{
        self.request.predicate = NSPredicate(format: "cPrenom == %@", prenom)
        do{
            return try CoreDataManager.context.count(for: self.request)
        }
        catch let error as NSError{
            fatalError(error.description)
        }
    }
    
    static func search(forPrenom prenom: String) -> [Configuration]?{
        self.request.predicate = NSPredicate(format: "cPrenom == %@", prenom)
        do{
            let result = try CoreDataManager.context.fetch(request) as [Configuration]
            guard result.count != 0 else { return nil }
            return result
        }
        catch{
            return nil
        }
    }
    
    static func count(forNom nom: String, prenom: String) -> Int{
        self.request.predicate = NSPredicate(format: "cNom == %@ AND cPrenom == %@", nom, prenom)
        do{
            return try CoreDataManager.context.count(for: self.request)
        }
        catch let error as NSError{
            fatalError(error.description)
        }
    }
    
    static func search(forNom nom: String, prenom: String) -> [Configuration]?{
        self.request.predicate = NSPredicate(format: "cNom == %@ AND cPrenom == %@", nom, prenom)
        do{
            let result = try CoreDataManager.context.fetch(request) as [Configuration]
            guard result.count != 0 else { return nil }
            return result
        }
        catch{
            return nil
        }
    }
    
    static func count(forNom nom: String, prenom: String,  dateNaissance: String?) -> Int{
        if let dateNaissance = dateNaissance{
            self.request.predicate = NSPredicate(format: "cNom == %@ AND cPrenom == %@ AND cDateNaissance == %@", nom, prenom, dateNaissance as CVarArg)
        }
        else{
            self.request.predicate = NSPredicate(format: "cNom == %@ AND cPrenom == %@ AND cDateNaissance = nil", nom, prenom)
        }
        do{
            return try CoreDataManager.context.count(for: self.request)
        }
        catch let error as NSError{
            fatalError(error.description)
        }
    }
    
    static func search(forNom nom: String, prenom: String,  dateNaissance: String?) -> Configuration?{
        if let dateNaissance = dateNaissance{
            self.request.predicate = NSPredicate(format: "cNom == %@ AND cPrenom == %@ AND cDateNaissance == %@", nom, prenom, dateNaissance as CVarArg)
        }
        else{
            self.request.predicate = NSPredicate(format: "cNom == %@ AND cPrenom == %@ AND cDateNaissance = nil", nom, prenom)
        }
        do{
            let result = try CoreDataManager.context.fetch(request) as [Configuration]
            guard result.count != 0 else { return nil }
            return result[0]
        }
        catch{
            return nil
        }
    }
    
    static func count(Configuration: Configuration) -> Int{
        self.request.predicate = NSPredicate(format: "cNom == %@ AND cPrenom == %@ AND cDateNaissance == %@ AND cCivilite = %@", Configuration.nom, Configuration.prenom, Configuration.dateNaissance as CVarArg, Configuration.civilite)
        
        do{
            return try CoreDataManager.context.count(for: self.request)
        }
        catch let error as NSError{
            fatalError(error.description)
        }
    }
    
    static func search(Configuration: Configuration) -> Configuration?{
        self.request.predicate = NSPredicate(format: "cNom == %@ AND cPrenom == %@ AND cDateNaissance == %@ AND cCivilite = %@", Configuration.nom, Configuration.prenom, Configuration.dateNaissance as CVarArg, Configuration.civilite)

        do{
            let result = try CoreDataManager.context.fetch(request) as [Configuration]
            guard result.count != 0 else { return nil }
            return result[0]
        }
        catch{
            return nil
        }
    }
    
    static func add(Configuration: Configuration){
        if let _ = self.search(forNom: Configuration.nom, prenom: Configuration.prenom, dateNaissance: Configuration.dateNaissance){
            let _ = self.save()
        }
        else{
           let _ = self.createConfiguration(forNom: Configuration.nom, prenom: Configuration.prenom, dateNaissance: Configuration.dateNaissance, civilite: Configuration.civilite)

            let _ = self.save()
        }
    }
    
}
