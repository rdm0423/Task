//
//  TaskListTableViewController.swift
//  Task
//
//  Created by Ross McIlwaine on 5/19/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import UIKit
import CoreData

class TaskListTableViewController: UITableViewController, NSFetchedResultsControllerDelegate, ButtonTableViewCellDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        TaskController.sharedController.fetchedResultsController.delegate = self
        
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // Using Nil Coelescing 
        return TaskController.sharedController.fetchedResultsController.sections?.count ?? 0
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let sections = TaskController.sharedController.fetchedResultsController.sections else {
            return 0
        }
        return sections[section].numberOfObjects
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCellWithIdentifier("taskCell", forIndexPath: indexPath) as? ButtonTableViewCell,
            let task = TaskController.sharedController.fetchedResultsController.objectAtIndexPath(indexPath) as? Task else {
            return ButtonTableViewCell()
        }
        cell.updateWithTask(task)
        
        cell.delegate = self
        
        return cell
    }
    
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            
            guard let task = TaskController.sharedController.fetchedResultsController.objectAtIndexPath(indexPath) as? Task else {
                return
            }
            TaskController.sharedController.removeTask(task)
            
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        guard let sections = TaskController.sharedController.fetchedResultsController.sections,
            index = Int(sections[section].name) else {
                return nil
        }
        if index == 0 {
            return "Incomplete"
        } else {
            return "Complete"
        }
    }
    
    // MARK: NSFetchedResultsControllerDelegate
    func controllerWillChangeContent(controller: NSFetchedResultsController) {
        
        tableView.beginUpdates()
    }
    
    func controller(controller: NSFetchedResultsController, didChangeObject anObject: AnyObject, atIndexPath indexPath: NSIndexPath?, forChangeType type: NSFetchedResultsChangeType, newIndexPath: NSIndexPath?) {
        
        switch type {
        case .Insert:
            guard let newIndexPath = newIndexPath else {return}
            tableView.insertRowsAtIndexPaths([newIndexPath], withRowAnimation: .Automatic)
        case .Delete:
            guard let indexPath = indexPath else {return}
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        case.Move:
            guard let indexPath = indexPath,
                newIndexPath = newIndexPath else {return}
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            tableView.insertRowsAtIndexPaths([newIndexPath], withRowAnimation: .Automatic)
        case.Update:
            guard let indexPath = indexPath else {return}
            tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
        }
    }
    
    func controller(controller: NSFetchedResultsController, didChangeSection sectionInfo: NSFetchedResultsSectionInfo, atIndex sectionIndex: Int, forChangeType type: NSFetchedResultsChangeType) {
        
        switch type {
        case .Insert:
            tableView.insertSections(NSIndexSet(index: sectionIndex), withRowAnimation: .Automatic)
        case .Delete:
            tableView.deleteSections(NSIndexSet(index: sectionIndex), withRowAnimation: .Fade)
        case .Move:
            break
        case .Update:
            break
        }
    }
    
    func controllerDidChangeContent(controller: NSFetchedResultsController) {
        
        tableView.endUpdates()
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "toViewTask" {
            
            guard let destinationTableViewController = segue.destinationViewController as? TaskDetailTableViewController,
            indexPath = tableView.indexPathForSelectedRow,
                task = TaskController.sharedController.fetchedResultsController.objectAtIndexPath(indexPath) as? Task else {
                    return
            }
            destinationTableViewController.task = task
        }
    }
    
    // MARK: - ButtonTableViewCellDelegate
    
    func buttonCellButtonTapped(sender: ButtonTableViewCell) {
        guard let indexPath = tableView.indexPathForCell(sender),
            task = TaskController.sharedController.fetchedResultsController.objectAtIndexPath(indexPath) as? Task else {return}
        TaskController.sharedController.isCompleteValueToggle(task)
    }
 

}
