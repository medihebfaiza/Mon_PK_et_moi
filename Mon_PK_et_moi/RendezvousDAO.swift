//
//  RendezvousDAO.swift
//  Mon_PK_et_moi
//
//  Created by Mohamed-Iheb FAIZA on 23/03/2018.
//  Copyright © 2018 FAIZA&LECLER. All rights reserved.
//

import Foundation
import CoreData

class RendezvousDAO{
    static let request : NSFetchRequest<Rendezvous> = Rendezvous.fetchRequest()
    
    static func save(){
        CoreDataManager.save()
    }
    
    static func delete(Rendezvous: Rendezvous){
        CoreDataManager.context.delete(Rendezvous)
    }
    
    static func fetchAll() -> [Rendezvous]?{
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
    
    static private func createRendezvous() -> Rendezvous{
        return Rendezvous(context: CoreDataManager.context)
    }
    
    static func createRendezvous(forDate date: NSDate, medecin : Medecin) -> Rendezvous{
        let dao   = self.createRendezvous()
        dao.date  = date
        dao.estdemandepar = medecin
        return dao
    }
    
    static func createRendezvous(forDate date: NSDate, medecin : Medecin, rdvsemestre: Bool ) -> Rendezvous{
        let dao   = self.createRendezvous()
        dao.date  = date
        dao.estdemandepar = medecin
        dao.rendezvoussemestre = rdvsemestre
        return dao
    }
    
    static func count(forDate date: NSDate) -> Int{
        self.request.predicate = NSPredicate(format: "date == %@", date)
        do{
            return try CoreDataManager.context.count(for: self.request)
        }
        catch let error as NSError{
            fatalError(error.description)
        }
    }
    
    static func search(forDate date: NSDate) -> [Rendezvous]?{
        self.request.predicate = NSPredicate(format: "date == %@", date)
        do{
            let result = try CoreDataManager.context.fetch(request) as [Rendezvous]
            guard result.count != 0 else { return nil }
            return result
        }
        catch{
            return nil
        }
    }
    
    static func count (medecin : Medecin) -> Int{
        self.request.predicate = NSPredicate(format: "ANY estdemandepar == %@", medecin)
        do{
            return try CoreDataManager.context.count(for: self.request)
        }
        catch let error as NSError{
            fatalError(error.description)
        }
    }
    
    static func search(medecin : Medecin) -> [Rendezvous]?{
        self.request.predicate = NSPredicate(format: "estdemandepar == %@", medecin)
        do{
            let result = try CoreDataManager.context.fetch(request) as [Rendezvous]
            guard result.count != 0 else { return nil }
            return result
        }
        catch{
            return nil
        }
    }
    
    static func count(forDate date: NSDate, medecin: Medecin) -> Int{
        self.request.predicate = NSPredicate(format: "date == %@ AND estdemandepar == %@", date, medecin)
        do{
            return try CoreDataManager.context.count(for: self.request)
        }
        catch let error as NSError{
            fatalError(error.description)
        }
    }
    
    static func search(forDate date: NSDate, medecin: Medecin) -> [Rendezvous]?{
        self.request.predicate = NSPredicate(format: "date == %@ AND estdemandepar == %@", date, medecin)
        do{
            let result = try CoreDataManager.context.fetch(request) as [Rendezvous]
            guard result.count != 0 else { return nil }
            return result
        }
        catch{
            return nil
        }
    }
    
    static func count(forDate date: NSDate, medecin : Medecin, rdvsemestre: Bool?) -> Int{
        if let rendezvoussemestre = rdvsemestre{
            self.request.predicate = NSPredicate(format: "date == %@ AND estdemandepar == %@ AND rendezvoussemestre == %@", date, medecin, rendezvoussemestre as CVarArg)
        }
        else{
            self.request.predicate = NSPredicate(format: "date == %@ AND estdemandepar == %@ AND rendezvoussemestre = nil", date, medecin)
        }
        do{
            return try CoreDataManager.context.count(for: self.request)
        }
        catch let error as NSError{
            fatalError(error.description)
        }
    }
    
    static func search(forDate date: NSDate, medecin : Medecin, rdvsemestre: Bool?) -> Rendezvous?{
        if let rendezvoussemestre = rdvsemestre{
            self.request.predicate = NSPredicate(format: "date == %@ AND estdemandepar == %@ AND rendezvoussemestre == %@", date, medecin, rendezvoussemestre as CVarArg)
        }
        else{
            self.request.predicate = NSPredicate(format: "date == %@ AND estdemandepar == %@ AND rendezvoussemestre = nil", date, medecin)
        }
        do{
            let result = try CoreDataManager.context.fetch(request) as [Rendezvous]
            guard result.count != 0 else { return nil }
            return result[0]
        }
        catch{
            return nil
        }
    }
    
    static func count(Rendezvous: Rendezvous) -> Int{
        self.request.predicate = NSPredicate(format: "date == %@ AND  rendezvoussemestre == %@ AND estdemandepar == %@", Rendezvous.date!, Rendezvous.rendezvoussemestre as CVarArg, Rendezvous.estdemandepar!)
        do{
            return try CoreDataManager.context.count(for: self.request)
        }
        catch let error as NSError{
            fatalError(error.description)
        }
    }
    
    static func search(forRendezvous Rendezvous: Rendezvous) -> Rendezvous?{
        self.request.predicate = NSPredicate(format: "date == %@ AND  rendezvoussemestre == %@ AND estdemandepar == %@", Rendezvous.date!, Rendezvous.rendezvoussemestre as CVarArg, Rendezvous.estdemandepar!)

        do{
            let result = try CoreDataManager.context.fetch(request) as [Rendezvous]
            guard result.count != 0 else { return nil }
            return result[0]
        }
        catch{
            return nil
        }
    }
    
    static func add(Rendezvous: Rendezvous){
        if let _ = self.search(forDate: Rendezvous.date!, medecin: Rendezvous.estdemandepar!, rdvsemestre: Rendezvous.rendezvoussemestre){
            self.save()
        }
        else {
            let _ = self.createRendezvous(forDate: Rendezvous.date!, medecin: Rendezvous.estdemandepar!, rdvsemestre: Rendezvous.rendezvoussemestre)
        }
        self.save()
    }
}
