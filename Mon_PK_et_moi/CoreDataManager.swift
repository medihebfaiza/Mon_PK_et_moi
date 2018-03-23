//
//  CoreDataManager.swift
//  Mon_PK_et_moi
//
//  Created by Mohamed-Iheb FAIZA on 20/03/2018.
//  Copyright © 2018 FAIZA&LECLER. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class CoreDataManager:NSObject{
    
    static var context : NSManagedObjectContext {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            exit(EXIT_FAILURE)
        }
        return appDelegate.persistentContainer.viewContext
    }
    
    @discardableResult
    class func save() -> NSError? {
        //try to save it 
        do {
            try CoreDataManager.context.save()
            return nil
        }
        catch let error as NSError{
            return error
        }
    }
    static func entityIsEmpty(entityName : String) -> Bool
    {
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        guard NSEntityDescription.entity(forEntityName: entityName, in: CoreDataManager.context) != nil else {fatalError("Failed to initialize Evenement entity description")}
        do{
            let results:NSArray? = try CoreDataManager.context.fetch(request) as NSArray
            if let res = results
            {
                return res.count == 0
            }
            else
            {
                return true
            }
            
        }catch {return false}
    }

}
