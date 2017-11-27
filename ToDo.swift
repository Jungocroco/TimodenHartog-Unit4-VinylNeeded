//
//  ToDo.swift
//  ToDoList
//
//  Created by Timo den Hartog on 22-11-17.
//  Copyright © 2017 Timo den Hartog. All rights reserved.
//

import Foundation

class ToDo: NSObject, NSCoding {
    
    var title: String
    var isComplete: Bool
    var buyBefore: Date
    var notes: String?
    
    static let dueDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        return formatter
    }()
    
    struct PropertyKey {
        static let title = "title"
        static let isComplete = "isComplete"
        static let buyBefore = "buyBefore"
        static let notes = "notes"
    }
    
    static let DocumentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("todos")
    
    static func loadToDos() -> [ToDo]?  {
        return NSKeyedUnarchiver.unarchiveObject(withFile: ToDo.ArchiveURL.path) as? [ToDo]
    }
    
    static func loadSampleToDos() -> [ToDo] {
        let todo1 = ToDo(title: "ToDo One", isComplete: false, buyBefore: Date(), notes: "Notes 1")
        let todo2 = ToDo(title: "ToDo Two", isComplete: false, buyBefore: Date(), notes: "Notes 2")
        let todo3 = ToDo(title: "ToDo Three", isComplete: false, buyBefore: Date(), notes: "Notes 3")
        
        return [todo1, todo2, todo3]
    }
    
    static func saveToDos(_ todos: [ToDo]) {
        NSKeyedArchiver.archiveRootObject(todos, toFile: ToDo.ArchiveURL.path)
    }
    
    init(title: String, isComplete: Bool, buyBefore: Date, notes: String?) {
        
        guard !title.isEmpty else {
            fatalError("Reminder requires a non-empty title")
        }
        
        self.title = title
        self.isComplete = isComplete
        self.buyBefore = buyBefore
        self.notes = notes
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        
        guard let title = aDecoder.decodeObject(forKey: PropertyKey.title) as? String,
            let buyBefore = aDecoder.decodeObject(forKey: PropertyKey.buyBefore) as? Date else {
                return nil
        }
        
        let isComplete = aDecoder.decodeBool(forKey: PropertyKey.isComplete)
        let notes = aDecoder.decodeObject(forKey: PropertyKey.notes) as? String
        
        self.init(title: title, isComplete: isComplete, buyBefore: buyBefore, notes: notes)
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(title, forKey: PropertyKey.title)
        aCoder.encode(isComplete, forKey: PropertyKey.isComplete)
        aCoder.encode(buyBefore, forKey: PropertyKey.buyBefore)
        aCoder.encode(notes, forKey: PropertyKey.notes)
    }
}
