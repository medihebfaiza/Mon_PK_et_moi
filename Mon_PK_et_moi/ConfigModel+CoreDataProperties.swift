//
//  ConfigModel+CoreDataProperties.swift
//  Mon_PK_et_moi
//
//  Created by Hugo LECLER on 07/03/2018.
//  Copyright © 2018 FAIZA&LECLER. All rights reserved.
//

import Foundation
import CoreData


extension ConfigModel {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ConfigModel> {
        return NSFetchRequest<ConfigModel>(entityName: "ConfigModel")
    }

    @NSManaged public var dateNaissancePatient: NSDate?
    @NSManaged public var nomPatient: String?
    @NSManaged public var prenomPatient: String?
    @NSManaged public var sexePatient: String?

}
