//
//  MedecinDAO.swift
//  Mon_PK_et_moi
//
//  Created by Mohamed-Iheb FAIZA on 22/03/2018.
//  Copyright © 2018 FAIZA&LECLER. All rights reserved.
//

import Foundation
import CoreData

class MedecinDAO{
    static let request : NSFetchRequest<Medecin> = Medecin.fetchRequest()
    
    static func save(){
        CoreDataManager.save()
    }
    
    static func delete(Medecin: Medecin){
        CoreDataManager.context.delete(Medecin)
    }
    
    static func fetchAll() -> [Medecin]?{
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
    
    static private func createMedecin() -> Medecin{
        return Medecin(context: CoreDataManager.context)
    }
    
    static func createMedecin(forNom nom: String, prenom: String, adresseEmail: String) -> Medecin{
        let dao             = self.createMedecin()
        dao.nom             = nom
        dao.prenom          = prenom
        dao.adresseEmail    = adresseEmail
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
    
    static func search(forNom nom: String) -> [Medecin]?{
        self.request.predicate = NSPredicate(format: "nom == %@", nom)
        do{
            let result = try CoreDataManager.context.fetch(request) as [Medecin]
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
    
    static func search(forPrenom prenom: String) -> [Medecin]?{
        self.request.predicate = NSPredicate(format: "prenom == %@", prenom)
        do{
            let result = try CoreDataManager.context.fetch(request) as [Medecin]
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
    
    static func search(forNom nom: String, prenom: String) -> [Medecin]?{
        self.request.predicate = NSPredicate(format: "nom == %@ AND prenom == %@", nom, prenom)
        do{
            let result = try CoreDataManager.context.fetch(request) as [Medecin]
            guard result.count != 0 else { return nil }
            return result
        }
        catch{
            return nil
        }
    }
    
    static func count(forNom nom: String, prenom: String, adresseEmail: String) -> Int{
        if let adresseEmail = adresseEmail{
            self.request.predicate = NSPredicate(format: "nom == %@ AND prenom == %@ AND adresseEmail == %@", nom, prenom, adresseEmail)
        }
        else{
            self.request.predicate = NSPredicate(format: "nom == %@ AND prenom == %@ AND adresseEmail = nil", nom, prenom)
        }
        do{
            return try CoreDataManager.context.count(for: self.request)
        }
        catch let error as NSError{
            fatalError(error.description)
        }
    }
    
    static func search(forNom nom: String, prenom: String,  dateNaissance: NSDate?) -> Medecin?{
        if let dateNaissance = dateNaissance{
            self.request.predicate = NSPredicate(format: "nom == %@ AND prenom == %@ AND dateNaissance == %@", nom, prenom, dateNaissance as CVarArg)
        }
        else{
            self.request.predicate = NSPredicate(format: "nom == %@ AND prenom == %@ AND dateNaissance = nil", nom, prenom)
        }
        do{
            let result = try CoreDataManager.context.fetch(request) as [Medecin]
            guard result.count != 0 else { return nil }
            return result[0]
        }
        catch{
            return nil
        }
    }
    
    static func add(Medecin: Medecin){
        if let _ = self.search(forNom: Medecin.nom!, prenom: Medecin.prenom!, adresseEmail: Medecin.adresseEmail){
            self.save()
        }
        else{
            if let dateNaissance = Medecin.dateNaissance{
                let _ = self.createMedecin(forNom: Medecin.nom, prenom: Medecin.prenom, dateNaissance: dateNaissance)
            }
            else{
                let _ = self.createMedecin(forNom: Medecin.nom, prenom: Medecin.prenom)
            }
            self.save()
        }
    }
    
}
