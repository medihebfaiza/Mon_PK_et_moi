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
    
    static func save() -> NSError? {
        return CoreDataManager.save()
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
    
    static func createMedecin(forNom nom: String, prenom: String, adresseEmail: String?, numTelephone: String?) -> Medecin{
        let dao           = self.createMedecin()
        dao.mNom          = nom
        dao.mPrenom       = prenom
        dao.mAdresseEmail = adresseEmail
        dao.mNumTelephone = numTelephone
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
    
    static func count(forNom nom: String, prenom: String, adresseEmail: String?) -> Int{
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
    
    static func search(forNom nom: String, prenom: String, adresseEmail: String?) -> Medecin?{
        if let adresseEmail = adresseEmail{
            self.request.predicate = NSPredicate(format: "nom == %@ AND prenom == %@ AND adresseEmail == %@", nom, prenom, adresseEmail as CVarArg)
        }
        else{
            self.request.predicate = NSPredicate(format: "nom == %@ AND prenom == %@ AND adresseEmail = nil", nom, prenom)
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
    
    static func search(medecin : Medecin) -> Medecin?{
        if medecin.adresseEmail != nil && medecin.numTelephone != nil {
            self.request.predicate = NSPredicate(format: "nom == %@ AND prenom == %@ AND adresseEmail == %@ AND numTelephone == %@", medecin.nom, medecin.prenom, medecin.adresseEmail!, medecin.numTelephone!)
        }
        else if medecin.adresseEmail != nil{
            self.request.predicate = NSPredicate(format: "nom == %@ AND prenom == %@ AND adresseEmail = nil AND numTelephone == %@", medecin.nom, medecin.prenom, medecin.numTelephone!)
        }
        else if medecin.numTelephone != nil{
            self.request.predicate = NSPredicate(format: "nom == %@ AND prenom == %@ AND adresseEmail = %@ AND numTelephone == nil", medecin.nom, medecin.prenom, medecin.adresseEmail!)
        }
        else {
            self.request.predicate = NSPredicate(format: "nom == %@ AND prenom == %@ AND adresseEmail = nil AND numTelephone == nil", medecin.nom, medecin.prenom)
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
    
    static func add(medecin: Medecin){
        if search(medecin : medecin) != nil{
            let _ = self.save()
        }
        else{
            if medecin.adresseEmail != nil && medecin.numTelephone != nil{
                let _ = self.createMedecin(forNom: medecin.nom, prenom: medecin.prenom, adresseEmail: medecin.adresseEmail, numTelephone: medecin.numTelephone)
            }
            else{
                let _ = self.createMedecin(forNom: medecin.nom, prenom: medecin.prenom, adresseEmail : nil, numTelephone : nil)
            }
            let _ = self.save()
        }
    }
    
}
