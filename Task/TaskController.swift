//
//  TaskController.swift
//  Task
//
//  Created by Ross McIlwaine on 5/18/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import Foundation
import CoreData

class TaskController {
    
    static let sharedController = TaskController()
    
    // MOCK DATA
    var mockTasks:[Task] {
        
        let mocTask1 = Task(name: "Do PreClass work", notes: "Moving on With Core Data")
        let mocTask2 = Task(name: "Get Groceries", notes: "Salad, Chicken, bread")
        mocTask2!.isComplete = true
        let mocTask3 = Task(name: "Clean Room", notes: "Vaccum")
        let mocTask4 = Task(name: "Get Gas from Costco", notes: "Add Fuel enahancer")
        let mocTask5 = Task(name: "Figure out CO", notes: "BV Festival")
        let mocTask6 = Task(name: "Go for a Run", notes: "2 miles")
        mocTask6!.isComplete = true
        
        return [mocTask1!, mocTask2!, mocTask3!, mocTask4!, mocTask5!, mocTask6!]
    }
    
    
    var tasks:[Task] = []
    
    
    var completedTasks:[Task] {
        
        return tasks.filter({$0.isComplete.boolValue})
    }
    
    var incompleteTasks:[Task] {
        
        return tasks.filter({!$0.isComplete.boolValue})
    }
    
    init() {
        
        self.tasks = fetchTasks()
    }
    
    func addTask(name: String, notes: String?, due: NSDate?) {
        
        let _ = Task(name: name, notes: notes, due: due)
        saveToPersistentStore()
        tasks = fetchTasks()
    }
    
    func removeTask(task: Task) {
        
        task.managedObjectContext?.deleteObject(task)
        saveToPersistentStore()
        tasks = fetchTasks()
    }
    
    func updateTask(task: Task, name: String, notes: String?, due: NSDate?) {
        
        task.name = name
        task.notes = notes
        task.due = due
        saveToPersistentStore()
        tasks = fetchTasks()
    }
    
    func isCompleteValueToggle(task: Task) {
        task.isComplete = !task.isComplete.boolValue
        saveToPersistentStore()
        tasks = fetchTasks()
    }
    
    func saveToPersistentStore() {
        
        do {
            try Stack.sharedStack.managedObjectContext.save()
        } catch {
            print("Error when trying to save via Managed Object Context. Not saved.")
        }
    }
    
    func fetchTasks() -> [Task] {
        
        let request = NSFetchRequest(entityName: "Task")
        
        let tasks = (try? Stack.sharedStack.managedObjectContext.executeFetchRequest(request)) as? [Task]
        return tasks ?? []
    }
    
}