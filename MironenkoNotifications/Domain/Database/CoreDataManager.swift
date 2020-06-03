//
//  CoreDataManager.swift
//  MironenkoNotifications
//
//  Created by Mironenko Evgeniy on 6/3/20.
//  Copyright © 2020 Mironenko Evgeniy. All rights reserved.
//

import Foundation
import CoreData
import UIKit


class NSCustomPersistentContainer: NSPersistentContainer {
    
    override open class func defaultDirectoryURL() -> URL {
        let storeURL = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: "group.mironenko.test")
        return storeURL!
    }
    
}

class CoreDataManager {
    
    static let sharedManager = CoreDataManager()
    private init() {}
    
    lazy var persistentContainer: NSCustomPersistentContainer = {
        
        let container = NSCustomPersistentContainer(name: "MironenkoNotifications")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    func saveContext () {
        
        let context = CoreDataManager.sharedManager.persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Error \(nserror), \(nserror.userInfo)");
            }
        }
    }
    
    func fetchAllPushes() -> [MIRPush]?{
        
        let context = CoreDataManager.sharedManager.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "MIRPush");
        
        do {
            let pushes = try context.fetch(fetchRequest)
            return pushes as? [MIRPush];
        } catch let error as NSError {
            print("Error: Could not fetch. \(error), \(error.userInfo)");
            return nil;
        }
    }
    
    func fetchAllPushesCount() -> Int {
        
        let context = CoreDataManager.sharedManager.persistentContainer.viewContext;
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "MIRPush");
        
        do {
            let count = try context.count(for: fetchRequest);
            return count;
        } catch let error as NSError {
            print("Error: Could not fetch count. \(error), \(error.userInfo)");
            return 0;
        }
            
    }
    
    func insertPushWithText(text: String,
                            recievedDate: Date,
                            recievedNumber: Int,
                            computedNumber: Int,
                            isSilent: Bool) -> MIRPush? {
        
        let managedContext = CoreDataManager.sharedManager.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "MIRPush", in: managedContext)!
        
        let push = NSManagedObject(entity: entity, insertInto: managedContext);
        push.setValue(text, forKeyPath: "titleText");
        push.setValue(computedNumber, forKeyPath: "computedNumber");
        push.setValue(isSilent, forKeyPath: "isSilent");
        push.setValue(recievedNumber, forKeyPath: "receivedNumber");
        push.setValue(recievedDate, forKeyPath: "receivedDate");
        
        do {
            try managedContext.save()
            return push as? MIRPush;
        } catch let error as NSError {
            print("Error: Could not insert \(error), \(error.userInfo)")
            return nil;
        }
    }
    
    func update(name:String, push : MIRPush) {
        
    }
    
    func delete(push : MIRPush){

    }
}

