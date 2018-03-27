//
//  EvenementDAO.swift
//  Mon_PK_et_moi
//
//  Created by Mohamed-Iheb FAIZA on 24/03/2018.
//  Copyright © 2018 FAIZA&LECLER. All rights reserved.
//

import Foundation
import CoreData

class EvenementDAO{
    static let request : NSFetchRequest<Evenement> = Evenement.fetchRequest()
    
    static func save() -> NSError? {
        return CoreDataManager.save()
    }
    
    static func delete(Evenement: Evenement){
        CoreDataManager.context.delete(Evenement)
    }
    
    static func fetchAll() -> [Evenement]?{
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
    
    static private func createEvenement() -> Evenement{
        return Evenement(context: CoreDataManager.context)
    }
    
    static func createEvenement(forDate date: NSDate, libelle : String) -> Evenement{
        let dao   = self.createEvenement()
        dao.eDate  = date
        dao.eLibelle = libelle
        return dao
    }
    
    static func count(forDate date: NSDate) -> Int{
        self.request.predicate = NSPredicate(format: "(%@ <= eDate) AND (eDate < %@)", date, DateConverter.nextDay(date: date))
        do{
            return try CoreDataManager.context.count(for: self.request)
        }
        catch let error as NSError{
            fatalError(error.description)
        }
    }
    
    static func search(forDate date: NSDate) -> [Evenement]?{
        self.request.predicate = NSPredicate(format: "(%@ <= eDate) AND (eDate < %@)", date, DateConverter.nextDay(date: date))
        do{
            let result = try CoreDataManager.context.fetch(request) as [Evenement]
            guard result.count != 0 else { return [] }
            return result
        }
        catch{
            return []
        }
    }
    
    static func count(forDate date: NSDate, libelle: String) -> Int{
        self.request.predicate = NSPredicate(format: "(%@ <= eDate) AND (eDate < %@) AND eLibelle == %@", date, DateConverter.nextDay(date: date), libelle)
        do{
            return try CoreDataManager.context.count(for: self.request)
        }
        catch let error as NSError{
            fatalError(error.description)
        }
    }
    
    static func search(forDate date: NSDate, libelle: String) -> [Evenement]?{
        self.request.predicate = NSPredicate(format: "(%@ <= eDate) AND (eDate < %@) AND eLibelle == %@", date, DateConverter.nextDay(date: date), libelle)
        do{
            let result = try CoreDataManager.context.fetch(request) as [Evenement]
            guard result.count != 0 else { return [] }
            return result
        }
        catch{
            return []
        }
    }
    
    static func count(Evenement: Evenement) -> Int{
        self.request.predicate = NSPredicate(format: "eDate == %@ AND  eLibelle == %@", Evenement.eDate!, Evenement.eLibelle!)
        do{
            return try CoreDataManager.context.count(for: self.request)
        }
        catch let error as NSError{
            fatalError(error.description)
        }
    }
    
    static func search(forEvenement Evenement: Evenement) -> Evenement?{
        self.request.predicate = NSPredicate(format: "eDate == %@ AND  eLibelle == %@", Evenement.eDate!, Evenement.eLibelle!)
        
        do{
            let result = try CoreDataManager.context.fetch(request) as [Evenement]
            guard result.count != 0 else { return nil }
            return result[0]
        }
        catch{
            return nil
        }
    }
    
    static func add(Evenement: Evenement){
        if let _ = self.search(forDate: Evenement.eDate!, libelle: Evenement.eLibelle!){
            let _ = self.save()
        }
        else {
            let _ = self.createEvenement(forDate: Evenement.eDate!, libelle: Evenement.eLibelle!)
        }
        let _ = self.save()
    }
}
