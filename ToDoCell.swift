//
//  ToDoCell.swift
//  ToDoList
//
//  Created by Timo den Hartog on 24-11-17.
//  Copyright © 2017 Timo den Hartog. All rights reserved.
//

import UIKit

@objc protocol ToDoCellDelegate: class {
    func checkmarkTapped(sender: ToDoCell)
}

class ToDoCell: UITableViewCell {
    var delegate: ToDoCellDelegate?
    
    @IBOutlet weak var isCompleteButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBAction func completeButtonTapped() {
        delegate?.checkmarkTapped(sender: self)
    }
}
