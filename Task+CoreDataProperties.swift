//
//  Task+CoreDataProperties.swift
//  Task
//
//  Created by Ross McIlwaine on 5/18/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Task {

    @NSManaged var name: String
    @NSManaged var notes: String?
    @NSManaged var due: NSDate?
    @NSManaged var isComplete: NSNumber

}
