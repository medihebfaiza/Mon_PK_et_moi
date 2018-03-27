//
//  MedicamentDAO.swift
//  Mon_PK_et_moi
//
//  Created by Mohamed-Iheb FAIZA on 27/03/2018.
//  Copyright © 2018 FAIZA&LECLER. All rights reserved.
//

import UIKit
import CoreData

class MedicamentDAO{
    static let request : NSFetchRequest<Medicament> = Medicament.fetchRequest()
    
    static func save() -> NSError? {
        return CoreDataManager.save()
    }
    
    static func delete(Medicament: Medicament){
        CoreDataManager.context.delete(Medicament)
    }
    
    static func fetchAll() -> [Medicament]?{
        self.request.predicate = nil
        do{
            return try CoreDataManager.context.fetch(self.request)
        }
        catch{
            return []
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
    
    static private func createMedicament() -> Medicament{
        return Medicament(context: CoreDataManager.context)
    }
    
    static func createMedicament(forDose dose: String, nom : String) -> Medicament{
        let dao   = self.createMedicament()
        dao.mDose  = dose
        dao.mNom = nom
        return dao
    }
    
    static func count(forNom nom: String) -> Int{
        self.request.predicate = NSPredicate(format: "mNom = %@)", nom)
        do{
            return try CoreDataManager.context.count(for: self.request)
        }
        catch let error as NSError{
            fatalError(error.description)
        }
    }
    
    static func search(forDose nom: String) -> [Medicament]?{
        self.request.predicate = NSPredicate(format: "mNom = %@)", nom)
        do{
            let result = try CoreDataManager.context.fetch(request) as [Medicament]
            guard result.count != 0 else { return [] }
            return result
        }
        catch{
            return []
        }
    }
    
    static func count(forDose dose: String, nom: String) -> Int{
        self.request.predicate = NSPredicate(format: "mDose AND mNom = %@", dose, nom)
        do{
            return try CoreDataManager.context.count(for: self.request)
        }
        catch let error as NSError{
            fatalError(error.description)
        }
    }
    
    static func search(forDose dose: String, nom: String) -> [Medicament]?{
        self.request.predicate = NSPredicate(format: "mDose AND mNom = %@", dose, nom)
        do{
            let result = try CoreDataManager.context.fetch(request) as [Medicament]
            guard result.count != 0 else { return [] }
            return result
        }
        catch{
            return []
        }
    }
    
    static func count(forTraitement traitement: Traitement) -> Int{
        self.request.predicate = NSPredicate(format: "ANY traitement = %@", traitement)
        do{
            return try CoreDataManager.context.count(for: self.request)
        }
        catch let error as NSError{
            fatalError(error.description)
        }
    }
    
    static func search(forTraitement traitement: Traitement) -> [Medicament]?{
        self.request.predicate = NSPredicate(format: "ANY traitement = %@", traitement)
        do{
            let result = try CoreDataManager.context.fetch(request) as [Medicament]
            guard result.count != 0 else { return [] }
            return result
        }
        catch{
            return []
        }
    }
    
    static func count(Medicament: Medicament) -> Int{
        self.request.predicate = NSPredicate(format: "mDose AND mNom = %@ AND traitement = %@", Medicament.mDose!, Medicament.mNom!, Medicament.traitement!)
        do{
            return try CoreDataManager.context.count(for: self.request)
        }
        catch let error as NSError{
            fatalError(error.description)
        }
    }
    
    static func search(forMedicament Medicament: Medicament) -> Medicament?{
        self.request.predicate = NSPredicate(format: "mDose AND mNom = %@ AND traitement = %@", Medicament.mDose!, Medicament.mNom!, Medicament.traitement!)
        
        do{
            let result = try CoreDataManager.context.fetch(request) as [Medicament]
            guard result.count != 0 else { return nil }
            return result[0]
        }
        catch{
            return nil
        }
    }
    
    static func add(Medicament: Medicament){
        if let _ = self.search(forDose: Medicament.mDose!, nom: Medicament.mNom!){
            let _ = self.save()
        }
        else {
            let _ = self.createMedicament(forDose: Medicament.mDose!, nom: Medicament.mNom!)
        }
        let _ = self.save()
    }
}
