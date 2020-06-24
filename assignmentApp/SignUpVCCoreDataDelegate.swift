import UIKit
import CoreData

class SignUpVCCoreDataDelegate: UIViewController {

    let signUpVCStoreManager = SignUpVCStoreManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func addUser(newUser: PojoClass){
        
        _ = signUpVCStoreManager.insertUser(newUser: newUser)

    }
    
    
    func fetchData(){

            let listOfUsers = signUpVCStoreManager.fetchAll()
//            for user in listOfUsers{
//                print("\(user.userName ?? "NA")")
//                print("\(user.lastName ?? "NA")")
//                print("\(user.email ?? "NA")")
//                print("\(user.phoneNumber)")
//                print("\(user.address ?? "NA")")
//                print("____________________")
//                print("")
//                print("")
//                }
    }
}
