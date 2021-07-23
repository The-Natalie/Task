//
//  TaskDetailViewController.swift
//  Task
//
//  Created by Natalie Hall on 7/21/21.
//

import UIKit

class TaskDetailViewController: UIViewController {

    @IBOutlet weak var taskNameTextField: UITextField!
    @IBOutlet weak var taskNotesTextView: UITextView!
    @IBOutlet weak var taskDueDatePicker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
        // Do any additional setup after loading the view.
    }
    
    var task: Task?
    var dueDate: Date?
    

    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let name = taskNameTextField.text, !name.isEmpty,
              let notes = taskNotesTextView.text, !notes.isEmpty else { return }
        
        if let task = task {
            TaskController.shared.update(task: task, newName: name, newNotes: notes, newDueDate: dueDate)
        } else {
            TaskController.shared.createTaskWith(name: name, notes: notes, dueDate: dueDate)
        }
        
        navigationController?.popViewController(animated: true)

    }
    
    @IBAction func dueDatePickerDateChanged(_ sender: Any) {
        dueDate = taskDueDatePicker.date
    }
    
    func updateViews() {
        guard let task = task else { return }
        taskNameTextField.text = task.name
        taskNotesTextView.text = task.notes
        taskDueDatePicker.date = task.dueDate ?? Date()
    }
    
}
