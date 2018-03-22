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
    
    static func save(){
        CoreDataManager.save()
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
    
    static func createConfiguration(forNom nom: String, prenom: String, dateNaissance: NSDate, civilite: String) -> Configuration{
        let dao             = self.createConfiguration()
        dao.nom             = nom
        dao.prenom          = prenom
        dao.dateNaissance   = dateNaissance
        dao.civilite        = civilite
        return dao
    }
    
    static func count(forNom nom: String) -> Int{
        self.request.predicate = NSPredicate(format: "nom == %@", nom)
        do{
            return try CoreDataManager.context.count(for: self.request)
        }
        catch let error as NSError{
            fatalError(error.description)
        }
    }
    
    static func search(forNom nom: String) -> [Configuration]?{
        self.request.predicate = NSPredicate(format: "nom == %@", nom)
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
        self.request.predicate = NSPredicate(format: "prenom == %@", prenom)
        do{
            return try CoreDataManager.context.count(for: self.request)
        }
        catch let error as NSError{
            fatalError(error.description)
        }
    }
    
    static func search(forPrenom prenom: String) -> [Configuration]?{
        self.request.predicate = NSPredicate(format: "prenom == %@", prenom)
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
        self.request.predicate = NSPredicate(format: "nom == %@ AND prenom == %@", nom, prenom)
        do{
            return try CoreDataManager.context.count(for: self.request)
        }
        catch let error as NSError{
            fatalError(error.description)
        }
    }
    
    static func search(forNom nom: String, prenom: String) -> [Configuration]?{
        self.request.predicate = NSPredicate(format: "nom == %@ AND prenom == %@", nom, prenom)
        do{
            let result = try CoreDataManager.context.fetch(request) as [Configuration]
            guard result.count != 0 else { return nil }
            return result
        }
        catch{
            return nil
        }
    }
    
    static func count(forNom nom: String, prenom: String,  dateNaissance: Date?) -> Int{
        if let dateNaissance = dateNaissance{
            self.request.predicate = NSPredicate(format: "nom == %@ AND prenom == %@ AND dateNaissance == %@", nom, prenom, dateNaissance as CVarArg)
        }
        else{
            self.request.predicate = NSPredicate(format: "nom == %@ AND prenom == %@ AND dateNaissance = nil", nom, prenom)
        }
        do{
            return try CoreDataManager.context.count(for: self.request)
        }
        catch let error as NSError{
            fatalError(error.description)
        }
    }
    
    static func search(forNom nom: String, prenom: String,  dateNaissance: NSDate?) -> Configuration?{
        if let dateNaissance = dateNaissance{
            self.request.predicate = NSPredicate(format: "nom == %@ AND prenom == %@ AND dateNaissance == %@", nom, prenom, dateNaissance as CVarArg)
        }
        else{
            self.request.predicate = NSPredicate(format: "nom == %@ AND prenom == %@ AND dateNaissance = nil", nom, prenom)
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
        if let dateNaissance = Configuration.dateNaissance{
            self.request.predicate = NSPredicate(format: "nom == %@ AND prenom == %@ AND dateNaissance == %@", Configuration.nom!, Configuration.prenom!, dateNaissance as CVarArg)
        }
        else{
            self.request.predicate = NSPredicate(format: "nom == %@ AND prenom == %@ AND dateNaissance = nil", Configuration.nom!, Configuration.prenom!)
        }
        do{
            return try CoreDataManager.context.count(for: self.request)
        }
        catch let error as NSError{
            fatalError(error.description)
        }
    }
    
    static func search(forConfiguration Configuration: Configuration) -> Configuration?{
        if let dateNaissance = Configuration.dateNaissance{
            self.request.predicate = NSPredicate(format: "nom == %@ AND prenom == %@ AND dateNaissance == %@", Configuration.nom!, Configuration.prenom!, dateNaissance as CVarArg)
        }
        else{
            self.request.predicate = NSPredicate(format: "nom == %@ AND prenom == %@ AND dateNaissance = nil", Configuration.nom!, Configuration.prenom!)
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
    
    static func add(Configuration: Configuration){
        if let _ = self.search(forNom: Configuration.nom!, prenom: Configuration.prenom!, dateNaissance: Configuration.dateNaissance){
            self.save()
        }
        else{
            if let dateNaissance = Configuration.dateNaissance{
                let _ = self.createConfiguration(forNom: Configuration.nom, prenom: Configuration.prenom, dateNaissance: dateNaissance)
            }
            else{
                let _ = self.createConfiguration(forNom: Configuration.nom, prenom: Configuration.prenom)
            }
            self.save()
        }
    }
    
}
