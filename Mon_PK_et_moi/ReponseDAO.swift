//
//  ReponseDAO.swift
//  Mon_PK_et_moi
//
//  Created by Mohamed Iheb Faiza on 26/03/2018.
//  Copyright © 2018 FAIZA&LECLER. All rights reserved.
//

import Foundation
import CoreData

class ReponseDAO{
    static let request : NSFetchRequest<Reponse> = Reponse.fetchRequest()
    
    static func save() -> NSError? {
        return CoreDataManager.save()
    }
    
    static func delete(Reponse: Reponse){
        CoreDataManager.context.delete(Reponse)
    }
    
    static func fetchAll() -> [Reponse]?{
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
    
    static private func createReponse() -> Reponse{
        return Reponse(context: CoreDataManager.context)
    }
    
    static func createReponse(forDate date: NSDate, libelle : String) -> Reponse{
        let dao   = self.createReponse()
        dao.rDate  = date
        dao.rLibelle = libelle
        return dao
    }
    
    static func count(forDate date: NSDate) -> Int{
        self.request.predicate = NSPredicate(format: "(%@ <= rDate) AND (rDate < %@)", date, DateConverter.nextDay(date: date))
        do{
            return try CoreDataManager.context.count(for: self.request)
        }
        catch let error as NSError{
            fatalError(error.description)
        }
    }
    
    static func search(forDate date: NSDate) -> [Reponse]?{
        self.request.predicate = NSPredicate(format: "(%@ <= rDate) AND (rDate < %@)", date, DateConverter.nextDay(date: date))
        do{
            let result = try CoreDataManager.context.fetch(request) as [Reponse]
            guard result.count != 0 else { return [] }
            return result
        }
        catch{
            return []
        }
    }
    
    static func count(forDate date: NSDate, libelle: String) -> Int{
        self.request.predicate = NSPredicate(format: "(%@ <= rDate) AND (rDate < %@) AND rLibelle == %@", date, DateConverter.nextDay(date: date), libelle)
        do{
            return try CoreDataManager.context.count(for: self.request)
        }
        catch let error as NSError{
            fatalError(error.description)
        }
    }
    
    static func search(forDate date: NSDate, libelle: String) -> [Reponse]?{
        self.request.predicate = NSPredicate(format: "(%@ <= rDate) AND (rDate < %@) AND rLibelle == %@", date, DateConverter.nextDay(date: date), libelle)
        do{
            let result = try CoreDataManager.context.fetch(request) as [Reponse]
            guard result.count != 0 else { return [] }
            return result
        }
        catch{
            return []
        }
    }
    
    static func count(Reponse: Reponse) -> Int{
        self.request.predicate = NSPredicate(format: "rDate == %@ AND  rLibelle == %@", Reponse.rDate!, Reponse.rLibelle!)
        do{
            return try CoreDataManager.context.count(for: self.request)
        }
        catch let error as NSError{
            fatalError(error.description)
        }
    }
    
    static func search(forReponse Reponse: Reponse) -> Reponse?{
        self.request.predicate = NSPredicate(format: "rDate == %@ AND  rLibelle == %@", Reponse.rDate!, Reponse.rLibelle!)
        
        do{
            let result = try CoreDataManager.context.fetch(request) as [Reponse]
            guard result.count != 0 else { return nil }
            return result[0]
        }
        catch{
            return nil
        }
    }
    
    static func add(Reponse: Reponse){
        if let _ = self.search(forDate: Reponse.rDate!, libelle: Reponse.rLibelle!){
            let _ = self.save()
        }
        else {
            let _ = self.createReponse(forDate: Reponse.rDate!, libelle: Reponse.rLibelle!)
        }
            let _ = self.save()
    }
}
