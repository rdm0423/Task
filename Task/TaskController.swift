//
//  TaskController.swift
//  Task
//
//  Created by Caleb Hicks on 10/20/15.
//  Copyright © 2015 DevMountain. All rights reserved.
//

import Foundation
import CoreData

class TaskController {
    
    private let TaskKey = "tasks"
    
    static let sharedController = TaskController()
    let fetchedRequestsController: NSFetchedResultsController
    
//    var mockTasks:[Task] {
//        let sampleTask1 = Task(name: "Go grocery shopping", notes: "Costco")
//        let sampleTask2 = Task(name: "Pay rent", notes: "344 South State Street, SLC, Utah", due: NSDate(timeIntervalSinceNow: NSTimeInterval(60*60*24*3)))
//        let sampleTask3 = Task(name: "Finish work project")
//        let sampleTask4 = Task(name: "Install new light fixture", notes: "Downstairs bathroom")
//        sampleTask4.isComplete = true
//        let sampleTask5 = Task(name: "Order pizza")
//        sampleTask5.isComplete = true
//        
//        return [sampleTask1, sampleTask2, sampleTask3, sampleTask4]
//    }
    

    
    init() {
        let request = NSFetchRequest(entityName: "Task")
        let sortDescriptor1 = NSSortDescriptor(key: "isComplete", ascending: false)
        let sortDescriptor2 = NSSortDescriptor(key: "due", ascending: false)
        request.sortDescriptors = [sortDescriptor1, sortDescriptor2]
        self.fetchedRequestsController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: Stack.sharedStack.managedObjectContext, sectionNameKeyPath: "isComplete", cacheName: nil)
        
        do {
            try fetchedRequestsController.performFetch()
        } catch {
            fatalError("Failed to initialize FetchedResultsController: \(error)")
        }
    }
    
    func addTask(name: String, notes: String?, due: NSDate?) {
        let _ = Task(name: name, notes: notes, due: due)
        saveToPersistentStorage()
        
    }
    
    func updateTask(task: Task, name: String, notes: String?, due: NSDate?) {
        task.name = name
        task.notes = notes
        task.due = due
        saveToPersistentStorage()
        
    }
    
    func removeTask(task: Task) {
        
        task.managedObjectContext?.deleteObject(task)
        saveToPersistentStorage()
        
    }
    
    func isCompleteValueToggle(task: Task) {
        task.isComplete = !task.isComplete.boolValue
        saveToPersistentStorage()
        
    }
    
    // MARK: - Persistence
    
    func saveToPersistentStorage() {
        
        do {
            try Stack.sharedStack.managedObjectContext.save()
        } catch {
            print("Error saving Managed Object Context. Items not saved.")
        }
    }
    
}