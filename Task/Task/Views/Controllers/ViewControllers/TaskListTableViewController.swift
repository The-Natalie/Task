//
//  TaskListTableViewController.swift
//  Task
//
//  Created by Natalie Hall on 7/21/21.
//

import UIKit

class TaskListTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        TaskController.shared.loadFromPersistentStorage()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
    }

    // MARK: - Table view data source
 
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return TaskController.shared.tasks.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "taskCell", for: indexPath) as? TaskTableViewCell else { return UITableViewCell() }

        let task = TaskController.shared.tasks[indexPath.row]
        
        cell.textLabel?.text = task.name
        
        cell.delegate = self
        
        cell.task = task
        
        return cell
    }

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let taskToDelete = TaskController.shared.tasks[indexPath.row]
            TaskController.shared.delete(task: taskToDelete)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    

    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "toTaskDetailVC" {
            guard let indexPath = tableView.indexPathForSelectedRow,
                  let destinationVC = segue.destination as? TaskDetailViewController else { return }
            
            let taskToSend = TaskController.shared.tasks[indexPath.row]
            destinationVC.task = taskToSend
        }
    }
    
}


extension TaskListTableViewController: TaskCompletionDelegate {
     func taskCellButtonTapped(_ sender: TaskTableViewCell) {
        guard let task = sender.task else { return }

        TaskController.shared.toggleIsComplete(task: task)
        sender.updateViews()
}
    }

