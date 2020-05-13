//
//  Todo.swift
//  GetirTodo
//
//  Created by Mohammad reza Koohkan on 2/23/1399 AP.
//  Copyright © 1399 AP Mohamadreza Koohkan. All rights reserved.
//

import Foundation
import CoreData

@objc(Todo)
public class Todo: NSManagedObject {
    
    @NSManaged public var id: String?
    @NSManaged public var title: String?
    @NSManaged public var about: String?
    @NSManaged public var dueDate: Date?
    @NSManaged public var createdAt: Date?
    @NSManaged public var updatedAt: Date?
    @NSManaged public var completed: Bool
    @NSManaged public var softDeleted: Bool
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Todo> {
        return NSFetchRequest<Todo>(entityName: "Todo")
    }
    
    fileprivate var timeFormatter: DateFormatter = {
       let formatter = DateFormatter()
        formatter.dateFormat = "MM-dd-yyyy HH:mm"
        return formatter
    }()
    
    fileprivate var dateFormatter: DateFormatter = {
       let formatter = DateFormatter()
        formatter.dateFormat = "EEEE, MMM d, yyyy"
        return formatter
    }()
    
    var predicate: NSPredicate {
        return .init("id", self.id)
    }
    
    var time: String? {
        guard let _date = self.dueDate else { return self.durationStatus.text }
        return self.timeFormatter.string(from: _date).components(separatedBy: " ").last
    }
    
    var date: String? {
        guard let _date = self.dueDate else { return nil }
        return self.dateFormatter.string(from: _date)
    }
    
    var weekDay: String? {
        guard let _date = self.date else { return nil }
        return _date.components(separatedBy: ", ").first
    }
    
    var dayInMonth: String? {
        guard let _date = self.date else { return nil }
        return _date.components(separatedBy: ", ")[1]
    }
    
    var year: String? {
        guard let _date = self.date else { return nil }
        return _date.components(separatedBy: ", ").last
    }
    
    
    lazy var durationStatus: DurationStatus = {
        let twelveHour: TimeInterval = 43_200
        let now = Date().timeIntervalSince1970
        let next = (self.dueDate?.timeIntervalSince1970) ?? (self.createdAt!.timeIntervalSince1970 + twelveHour)
        let remaining = next - now
        if remaining > twelveHour {
            return .normal
        }else if remaining < 0 {
            return .over
        }else{
            return .soon
        }
    }()
    
    func contains(query: String) -> Bool {
        return self.title?.lowercased().hasPrefix(query) == true
    }

    func create() {
        Todo.add(title: self.title!, about: self.about!, dueDate: self.dueDate!)
    }
    
    func update() {
        self.modificationOccurred()
    }
    
}

extension Todo {
    
    @discardableResult
    class func add(title: String, about: String, dueDate: Date) -> Todo {
        let todo = Todo.create {
            $0.title = title
            $0.about = about
            $0.dueDate = dueDate
            $0.completed = false
            $0.softDeleted = false
            $0.id = UUID().uuidString
            $0.createdAt = Date()
            $0.updatedAt = Date()
        }
        todo.modificationOccurred()
        return todo
    }
    
    func edit(title: String, about: String, dueDate: Date) {
        self.title = title
        self.about = about
        self.dueDate = dueDate
        self.updatedAt = Date()
        self.modificationOccurred()
    }
    
    func complete() {
        self.completed = true
        self.softDeleted = false
        self.updatedAt = Date()
        self.modificationOccurred()
    }
    
    func softDelete() {
        self.softDeleted = true
        self.completed = true
        self.updatedAt = Date()
        self.modificationOccurred()
    }
    
    func modificationOccurred() {
        Todo.save()
        Main.shared.database.reload()
    }
    
}


extension Todo: Orm {
    
    class var sortDescriptor: NSSortDescriptor {
        return NSSortDescriptor(key: "dueDate", ascending: true)
    }
    
    class var todoPrediction: NSPredicate {
        return NSPredicate(format: "completed = %d AND softDeleted = %d", false, false)
    }
    
    class var completedPrediction: NSPredicate {
        return NSPredicate(format: "completed = %d AND softDeleted = %d", true, false)
    }
    
    class var softDeletedPrediction: NSPredicate {
        return NSPredicate(format: "softDeleted = %d", true)
    }
    
    class func request(_ prediction: NSPredicate? = nil) -> [Todo] {
        let request: NSFetchRequest<Todo> = Todo.fetchRequest()
        request.sortDescriptors = [Todo.sortDescriptor]
        return self.fetch(request, prediction: prediction)
    }
    
    class func all() -> [Todo] {
        return self.request()
    }
    
    class func allTodos() -> [Todo] {
        return self.request(self.todoPrediction)
    }
    
    class func completedTodos() -> [Todo] {
        return self.request(self.completedPrediction)
    }
    
    class func softDeletedTodos() -> [Todo] {
        return self.request(self.softDeletedPrediction)
    }
    
    class func deleteAllTodos() {
        Todo.erase()
    }

}
