
import XCTest
import CoreData
@testable import assignmentApp

class CoreDataTests: XCTestCase {

    var sut: SignUpVCStoreManager!
    
    lazy var managedObjectModel: NSManagedObjectModel = {
        let managedObjectModel = NSManagedObjectModel.mergedModel(from: [Bundle(for: type(of: self))] )!
        return managedObjectModel
    }()
    
    lazy var mockPersistantContainer: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "UserModel", managedObjectModel: self.managedObjectModel)
        let description = NSPersistentStoreDescription()
        description.type = NSInMemoryStoreType
        description.shouldAddStoreAsynchronously = false // Make it simpler in test env
        
        container.persistentStoreDescriptions = [description]
        container.loadPersistentStores { (description, error) in
            // Check if the data store is in memory
            precondition( description.type == NSInMemoryStoreType )
                                        
            // Check if creating container wrong
            if let error = error {
                fatalError("Create an in-mem coordinator failed \(error)")
            }
        }
        return container
    }()
    

    override func setUp() {
        super.setUp()
        initStubs()//Create stubs
        sut = SignUpVCStoreManager(container: mockPersistantContainer)
    }
    
    override func tearDown() {
        flushData() // Clear all stubs
        super.tearDown()
    }
    
    //To use in-memory persistent store

//    var container = NSPersistentContainer(name: "UserModel")
//
//    container.loadPersistentStores { storeDescription, error in
//        if let error = error {
//            print("Unresolved error \(error)")
//        }
//    }
//
//    let description = NSPersistentStoreDescription()
//    description.type = NSInMemoryStoreType
    
    func initStubs() {
            
        func insertUser( user: PojoClass ) -> User? {
            let obj = NSEntityDescription.insertNewObject(forEntityName: "User", into: mockPersistantContainer.viewContext)

            obj.setValue(user.userName, forKey: "userName")
            obj.setValue(user.lastName, forKey: "lastName")
            obj.setValue(user.email, forKey: "email")
            obj.setValue(user.phoneNumber, forKey: "phoneNumber")
            obj.setValue(user.address, forKey: "address")

            return obj as? User
        }
        
        
        var newUser = PojoClass(userName: "Abhay", lastName: "Charan", email: "dey@test.com", phoneNumber: 0788222153, address: "3C Albert road Kolkata"
        )
        let _ = insertUser(user: newUser)
        
        newUser = PojoClass(userName: "Shubham", lastName: "Chauhan", email: "dvaishnav@test.com", phoneNumber: 222153, address: "Manas Road Kolkata"
        )
        let _ = insertUser(user: newUser)

        newUser = PojoClass(userName: "Bhakti Siddhant", lastName: "Sraswati", email: "acharya@gaudiya.com", phoneNumber: 0011222153, address: "chndraloka"
        )
        let _ = insertUser(user: newUser)
        
        do {
            try mockPersistantContainer.viewContext.save()
        }  catch {
            print("create fakes error \(error)")
        }
    }
    
    func flushData() {
        let fetchRequest:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        let objs = try! mockPersistantContainer.viewContext.fetch(fetchRequest)
        for case let obj as NSManagedObject in objs {
            mockPersistantContainer.viewContext.delete(obj)
        }
        try! mockPersistantContainer.viewContext.save()
    }
    
    func test_fetch_all_users() {

        //Given a storage with two todo
        //When fetch
        let results = sut.fetchAll()

        //Assert return five todo items
        XCTAssertEqual(results.count, 3)
            
    }
    
}
