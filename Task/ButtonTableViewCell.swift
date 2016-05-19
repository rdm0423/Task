//
//  ButtonTableViewCell.swift
//  Task
//
//  Created by Ross McIlwaine on 5/18/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import UIKit

//@IBDesignable

class ButtonTableViewCell: UITableViewCell {

    @IBOutlet weak var taskLabel: UILabel!
    @IBOutlet weak var detailTaskLabel: UILabel!
    @IBOutlet weak var completeButton: UIButton!
    
    var delegate: ButtonTableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func completeButtonTapped(sender: AnyObject) {
        
        if let delegate = delegate {
            delegate.buttonCellButtonTapped(self)
        }
    }
    
    func updateButton(isComplete: Bool) {
        
        if isComplete {
            completeButton.setImage(UIImage(named: "complete"), forState: .Normal)
        } else {
            completeButton.setImage(UIImage(named: "incomplete"), forState: .Normal)
        }
    }
}

protocol ButtonTableViewCellDelegate {
    
    func buttonCellButtonTapped(sender: ButtonTableViewCell)
}

extension ButtonTableViewCell {
    
    func updateWithTask(task: Task) {
        
        taskLabel.text = task.name
    
        // Reference Alarm App
        detailTaskLabel.text = "****Set As Date Format For DUE *****"
        
        updateButton(task.isComplete.boolValue)
    }
}