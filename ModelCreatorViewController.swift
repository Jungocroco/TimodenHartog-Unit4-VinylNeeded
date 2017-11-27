//
//  ModelCreatorViewController.swift
//  ToDoList
//
//  Created by Timo den Hartog on 23-11-17.
//  Copyright © 2017 Timo den Hartog. All rights reserved.
//

import UIKit

class ModelCreatorViewController: UITableViewController {
    
    var todo: ToDo?
    
    var isEndDatePickerHidden = true
    
    @IBOutlet weak var saveButton: UIBarButtonItem!

    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var isCompleteButton: UIButton!
    @IBOutlet weak var dueDateLabel: UILabel!
    @IBOutlet weak var dueDatePickerView: UIDatePicker!
    @IBOutlet weak var notesTextView: UITextView!
    
    override func viewDidLoad() {
    super.viewDidLoad()
    if let todo = todo {
        navigationItem.title = "Vinyl"
        titleTextField.text = todo.title
        isCompleteButton.isSelected = todo.isComplete
        dueDatePickerView.date = todo.buyBefore
        notesTextView.text = todo.notes
    } else {
        dueDatePickerView.date = Date().addingTimeInterval(24*60*60)
    }
    
    updateDueDateLabel(date: dueDatePickerView.date)
    updateSaveButtonState()
    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        guard segue.identifier == "saveUnwind" else { return }
        
        let title = titleTextField.text ?? "No Title"
        let isComplete = isCompleteButton.isSelected
        let buyBefore = dueDatePickerView.date
        let notes = notesTextView.text
        
        todo = ToDo(title: title, isComplete: isComplete, buyBefore: buyBefore, notes: notes)
    }
    
    func updateDueDateLabel(date: Date) {
        dueDateLabel.text = ToDo.dueDateFormatter.string(from: date)
    }
    
    func updateSaveButtonState() {
        let text = titleTextField.text ?? ""
        saveButton.isEnabled = !text.isEmpty
    }
    
    @IBAction func datePickerChanged(_ sender: UIDatePicker) {
        updateDueDateLabel(date: dueDatePickerView.date)
    }
    
    @IBAction func textEditingChanged(_ sender: UITextField) {
        updateSaveButtonState()
    }
    
    @IBAction func returnPressed(_ sender: UITextField) {
        titleTextField.resignFirstResponder()
    }
    
    @IBAction func isCompleteButtonTapped(_ sender: UIButton) {
        isCompleteButton.isSelected = !isCompleteButton.isSelected
    }
}
