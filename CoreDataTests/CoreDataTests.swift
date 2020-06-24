import CoreData
import XCTest
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
   
//MARK: Test cases
    func testAddUser(){
        
       let newUser = PojoClass(userName: "Citra", lastName: "Sakhi", email: "ashta@vrindavan.com", phoneNumber: 9996574321, address: "Panchatatva hall, Mayapur")
        
        let user1 = sut.insertUser(newUser: newUser)
        
        XCTAssertNotNil(user1)
    }
    
    func test_fetch_all_users() {
    //Given a storage with two todo
   // When fetch
           let results = sut.fetchAll()
     //      Assert return five todo items
           XCTAssertEqual(results.count, 3)
    }
        

}

//MARK: Creat some fakes
extension CoreDataTests {
       func initStubs() {
                       
                   func insertUser( userName: String, lastName: String, email:String, phoneNumber: Int64, address: String ) -> User? {
                       let obj = NSEntityDescription.insertNewObject(forEntityName: "User", into: mockPersistantContainer.viewContext)

                       obj.setValue(userName, forKey: "userName")
                       obj.setValue(lastName, forKey: "lastName")
                       obj.setValue(email, forKey: "email")
                       obj.setValue(phoneNumber, forKey: "phoneNumber")
                       obj.setValue(address, forKey: "address")

                       return obj as? User
                   }
                   
                   
       //            var newUser = PojoClass(
       //            )
                   let _ = insertUser(userName: "Abhay", lastName: "Charan", email: "dey@test.com", phoneNumber: 0788222153, address: "3C Albert road Kolkata")
                   
       //            newUser = PojoClass(userName: "Shubham", lastName: "Chauhan", email: "dvaishnav@test.com", phoneNumber: 222153, address: "Manas Road Kolkata"
       //            )
                   let _ = insertUser(userName: "Shubham", lastName: "Chauhan", email: "dvaishnav@test.com", phoneNumber: 222153, address: "Manas Road Kolkata")

       //            newUser = PojoClass(userName: "Bhakti Siddhant", lastName: "Saraswati", email: "acharya@gaudiya.com", phoneNumber: 0011222153, address: "chndraloka"
       //            )
                   let _ = insertUser(userName: "Bhakti Siddhant", lastName: "Saraswati", email: "acharya@gaudiya.com", phoneNumber: 0011222153, address: "chndraloka")
                   
                   print("INSERTING 3 USERS SUCCESSFUL")
                   
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

   }
       
