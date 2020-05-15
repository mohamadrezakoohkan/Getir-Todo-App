//
//  Orm.swift
//  GetirTodo
//
//  Created by Mohammad reza Koohkan on 2/23/1399 AP.
//  Copyright © 1399 AP Mohamadreza Koohkan. All rights reserved.
//

import UIKit.UIApplication
import CoreData

protocol Orm { var predicate: NSPredicate { get } }

extension Orm where Self: NSManagedObject {
    
    static var container: NSPersistentContainer {
        return AppDelegate.shared.persistentContainer
    }
    
    static var context: NSManagedObjectContext {
        return Self.container.viewContext
    }
    
    static var entity: NSEntityDescription {
        return NSEntityDescription.entity(forEntityName: String(describing: self), in: Self.context)!
    }
    
    static var deleteRequest: NSBatchDeleteRequest {
        return NSBatchDeleteRequest(fetchRequest: Self.fetchRequest())
    }
    
    static func save() {
        do { try Self.context.save() } catch { print(error) }
    }
    
    static func erase(context: NSManagedObjectContext = Self.context) {
        let req = Self.deleteRequest
        req.resultType = .resultTypeObjectIDs
        do {
            let result = try context.execute(req) as? NSBatchDeleteResult
            let changes: [AnyHashable: Any] = [
                NSDeletedObjectsKey: result?.result as! [NSManagedObjectID]
            ]
            NSManagedObjectContext.mergeChanges(fromRemoteContextSave: changes, into: [Self.context])
        } catch { print(error) }
        Self.save()
    }
    
    private static func new() -> Self {
        return NSManagedObject(entity: self.entity, insertInto: Self.context) as! Self
    }
    
    static func fetch(_ req: NSFetchRequest<Self>, prediction: NSPredicate? = nil) -> [Self] {
        req.predicate = prediction
        do { return try Self.context.fetch(req) }
        catch { print(error); return [] }
    }
    
    
    static func create(context: NSManagedObjectContext? = nil,_ block: ((Self) -> Void)? = nil) -> Self {
        let object = Self.new()
        block?(object)
        return object
    }
    
    var context: NSManagedObjectContext! {
        return self.managedObjectContext
    }
    
    func delete() {
        self.context.delete(self)
    }

}

extension NSPredicate {
    convenience init(_ propertyName: String,_ value: String?) {
        self.init(format: "\(propertyName) = '\(value ?? "")'")
    }
}
