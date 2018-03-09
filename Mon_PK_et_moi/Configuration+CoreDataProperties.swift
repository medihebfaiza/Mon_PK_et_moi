//
//  Configuration+CoreDataProperties.swift
//  Mon_PK_et_moi
//
//  Created by Hugo LECLER on 09/03/2018.
//  Copyright © 2018 FAIZA&LECLER. All rights reserved.
//

import Foundation
import CoreData


extension Configuration {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Configuration> {
        return NSFetchRequest<Configuration>(entityName: "Configuration")
    }

    @NSManaged public var age: Int16
    @NSManaged public var nomPatient: String?
    @NSManaged public var prenomPatient: String?
    @NSManaged public var sexePatient: String?

}
