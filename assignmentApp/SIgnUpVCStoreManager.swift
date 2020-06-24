//
//  SIgnUpVCStoreManager.swift
//  assignmentApp
//
//  Created by Pranjal Singhai on 04/06/20.
//  Copyright © 2020 Capgemini. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class SignUpVCStoreManager {
    let persistentContainer: NSPersistentContainer!
    
    init(container: NSPersistentContainer){
        self.persistentContainer = container
        self.persistentContainer.viewContext.automaticallyMergesChangesFromParent = true
    }
    
    convenience init() {
        //Use the default container for production environment
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            fatalError("Can not get shared app delegate")
        }
        self.init(container: appDelegate.persistentContainer)
    }
    
    lazy var backgroundContext: NSManagedObjectContext = {
        return self.persistentContainer.newBackgroundContext()
    }()
    
    //MARK: CRUD 
    func insertUser(newUser: PojoClass) -> User? {
        
        guard let user = NSEntityDescription.insertNewObject(forEntityName: "User", into: backgroundContext) as? User else { return nil }
        user.userName = newUser.userName
        user.lastName = newUser.lastName
        user.phoneNumber = Int64(newUser.phoneNumber)
        user.email = newUser.email
        user.address = newUser.address
        
        do{
            try backgroundContext.save()
        } catch let error as NSError{
            print("Failed saving in core data, \(error.userInfo)")
        }
        
        return user
    }

    func fetchAll() -> [User] {
       // print("........................................")
        let request: NSFetchRequest<User> = User.fetchRequest()
       // print("||||||||||||||||||||||||||||||||||||||||")
        let results = try? persistentContainer.viewContext.fetch(request)
       // print("========================================")
        for user in results!{
            print("\(user.userName ?? "NA")")
            print("\(user.lastName ?? "NA")")
            print("\(user.email ?? "NA")")
            print("\(user.phoneNumber)")
            print("\(user.address ?? "NA")")
            print("____________________")
            print("")
            print("")
        }
        return results ?? [User]()
    }

    func remove( objectID: NSManagedObjectID ) {
        let obj = backgroundContext.object(with: objectID)
        backgroundContext.delete(obj)
    }

    func save() {
        if backgroundContext.hasChanges {
            do {
                try backgroundContext.save()
            } catch {
                print("Save error \(error)")
            }
        }

    }
    
    
}
