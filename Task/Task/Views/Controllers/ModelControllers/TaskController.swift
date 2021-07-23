//
//  TaskController.swift
//  Task
//
//  Created by Natalie Hall on 7/21/21.
//

import Foundation

class TaskController {
    
    static let shared = TaskController()
    
    var tasks: [Task] = []


    func createTaskWith(name: String, notes: String?, dueDate: Date?) {
//        TaskController.shared.createTaskWith(name: name, notes: notes, dueDate: dueDate)
        let newTask = Task(name: name, notes: notes, dueDate: dueDate)
        tasks.append(newTask)
        
        saveToPersistentStorage()
    }

    func update(task: Task, newName: String, newNotes: String?, newDueDate: Date?) {
        task.name = newName
        task.notes = newNotes
        task.dueDate = newDueDate
        
        saveToPersistentStorage()
    }

    func toggleIsComplete(task: Task) {
        task.isComplete.toggle()
        
        saveToPersistentStorage()
    }

    func delete(task: Task) {
        guard let index = tasks.firstIndex(of: task) else { return }
        tasks.remove(at: index)
        
        saveToPersistentStorage()
    }
    
    func fileURL() -> URL {
        let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)  //userDomainMask is the user's home directory
        let fileURL = url[0].appendingPathComponent("Tasks.json")
        return fileURL
    }
    
    func saveToPersistentStorage() {
        do {
            let data = try JSONEncoder().encode(tasks)
            try data.write(to: fileURL())
        } catch {
            print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
        }
        
    }
    
    func loadFromPersistentStorage() {
        do {
            let data = try Data(contentsOf: fileURL())
            tasks = try JSONDecoder().decode([Task].self, from: data)
        } catch {
            print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
        }
    }
    
}


