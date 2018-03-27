//
//  SymptomeDAO.swift
//  Mon_PK_et_moi
//
//  Created by Mohamed-Iheb FAIZA on 27/03/2018.
//  Copyright © 2018 FAIZA&LECLER. All rights reserved.
//

import Foundation
import CoreData

class SymptomeDAO{
    static let request : NSFetchRequest<Symptome> = Symptome.fetchRequest()
    
    static func save() -> NSError? {
        return CoreDataManager.save()
    }
    
    static func delete(Symptome: Symptome){
        CoreDataManager.context.delete(Symptome)
    }
    
    static func fetchAll() -> [Symptome]?{
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
    
    static private func createSymptome() -> Symptome{
        return Symptome(context: CoreDataManager.context)
    }
    
    static func createSymptome(libelle : String) -> Symptome{
        let dao   = self.createSymptome()
        dao.sLibelle = libelle
        return dao
    }
    
    static func count(forDate date: NSDate) -> Int{
        self.request.predicate = NSPredicate(format: "ANY (%@ <= estSignaleLe.date) AND (estSignaleLe.date < %@)", date, DateConverter.nextDay(date: date))
        do{
            return try CoreDataManager.context.count(for: self.request)
        }
        catch let error as NSError{
            fatalError(error.description)
        }
    }
    
    static func search(forDate date: NSDate) -> [Symptome]?{
        self.request.predicate = NSPredicate(format: "(ANY %@ <= estSignaleLe.date) AND (ANY estSignaleLe.date < %@)", date, DateConverter.nextDay(date: date))
        do{
            let result = try CoreDataManager.context.fetch(request) as [Symptome]
            guard result.count != 0 else { return [] }
            return result
        }
        catch{
            return []
        }
    }
    
    static func count(libelle: String) -> Int{
        self.request.predicate = NSPredicate(format: "sLibelle == %@", libelle)
        do{
            return try CoreDataManager.context.count(for: self.request)
        }
        catch let error as NSError{
            fatalError(error.description)
        }
    }
    
    static func search(libelle: String) -> [Symptome]?{
        self.request.predicate = NSPredicate(format: "sLibelle == %@", libelle)
        do{
            let result = try CoreDataManager.context.fetch(request) as [Symptome]
            guard result.count != 0 else { return [] }
            return result
        }
        catch{
            return []
        }
    }
    
    static func count(symptome: Symptome) -> Int{
        self.request.predicate = NSPredicate(format: "eLibelle == %@ AND estSignaleLe == %@", symptome.sLibelle!, symptome.estSignaleLe!)
        do{
            return try CoreDataManager.context.count(for: self.request)
        }
        catch let error as NSError{
            fatalError(error.description)
        }
    }
    
    static func search(forSymptome symptome: Symptome) -> Symptome?{
        self.request.predicate = NSPredicate(format: "eLibelle == %@ AND estSignaleLe == %@", symptome.sLibelle!, symptome.estSignaleLe!)
        
        do{
            let result = try CoreDataManager.context.fetch(request) as [Symptome]
            guard result.count != 0 else { return nil }
            return result[0]
        }
        catch{
            return nil
        }
    }
    
    static func add(symptome: Symptome){
        if let _ = self.search(libelle: symptome.sLibelle!){
            let _ = self.save()
        }
        else {
            let _ = self.createSymptome(libelle: symptome.sLibelle!)
        }
        let _ = self.save()
    }
}
