//
//  TaskDetailTableViewController.swift
//  Task
//
//  Created by Ross McIlwaine on 5/18/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import UIKit

class TaskDetailTableViewController: UITableViewController {

    var task: Task?
    var dueDateValue: NSDate?
    
    @IBOutlet weak var taskNameTextField: UITextField!
    @IBOutlet weak var taskDueTextField: UITextField!
    @IBOutlet weak var taskNoteTextView: UITextView!
    @IBOutlet var dueDatePicker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Place date picket inside of TextField :)
        taskDueTextField.inputView = dueDatePicker
        
        if let task = task {
            updateWithTask(task)
        }

    }

    @IBAction func saveButtonTapped(sender: AnyObject) {
        
        updateTask()
        navigationController?.popViewControllerAnimated(true)
    }
    
    @IBAction func cancelButtonTapped(sender: AnyObject) {
        
        navigationController?.popViewControllerAnimated(true)
    }
    
    @IBAction func datePicketValueChanged(sender: AnyObject) {
        
        self.taskDueTextField.text = sender.date.stringValue()
        self.dueDateValue = sender.date
    }
    
    @IBAction func userTappedView(sender: AnyObject) {
        
        self.taskNameTextField.resignFirstResponder()
        self.taskDueTextField.resignFirstResponder()
        self.taskNoteTextView.resignFirstResponder()
    }
    
    func updateTask() {
        
        guard let name = taskNameTextField.text else {
            return
        }
        let due = dueDateValue
        let notes = taskNoteTextView.text
        
        if let task = self.task {
            TaskController.sharedController.updateTask(task, name: name, notes: notes, due: due)
        } else {
            TaskController.sharedController.addTask(name, notes: notes, due: due)
        }
    }
    
    func updateWithTask(task: Task) {
        
        self.task = task
        
        title = task.name
        
        taskNameTextField.text = task.name
        
        if let due = task.due {
            taskDueTextField.text = due.stringValue()
        }
        
        if let notes = task.notes {
            taskNoteTextView.text = notes
        }
        
    }
    
}
