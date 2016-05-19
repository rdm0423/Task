//
//  Task.swift
//  Task
//
//  Created by Ross McIlwaine on 5/18/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import Foundation
import CoreData

@objc(Task)

class Task: NSManagedObject {

// Insert code here to add functionality to your managed object subclass

    convenience init?(name: String, notes: String? = nil, due: NSDate? = nil, context: NSManagedObjectContext = Stack.sharedStack.managedObjectContext) {
        
        // there is no graceful way to respond to a failure on NSEntityDescription.entityForName, force unwrapping and forcing a crash is the desired behavior for this app
        
        // designated initializer
        let entity = NSEntityDescription.entityForName("Task", inManagedObjectContext: context)!
        
        self.init(entity: entity, insertIntoManagedObjectContext: context)
        
        // set properties here
        self.name = name
        self.notes = notes
        self.due = due
        self.isComplete = false
    }
}
