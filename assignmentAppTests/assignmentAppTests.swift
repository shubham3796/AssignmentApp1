import XCTest
@testable import assignmentApp

class assignmentAppTests: XCTestCase {
    
    var user: PojoClass!
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }


//    func testPerformanceExample() {
//        // This is an example of a performance test case.
//        self.measure {
//            // Put the code you want to measure the time of here.
//        }
//    }
    
    //MARK: Test Pojo class instance
    func testPojoClass_canCreateNewInstance() {
        user = PojoClass(userName: "Abhay", lastName: "Charan", email: "dey@test.com", phoneNumber: 0788222153, address: "3C Albert road Kolkata"
        )
           XCTAssertNotNil(user)
        }
    
    //MARK: Test validity of Pojo class properties
    func testUserFirstName_shouldPassIfValidUserName(){
        user = PojoClass(userName: "Abhay", lastName: "Charan", email: "dey@test.com", phoneNumber: 0788222153, address: "3C Albert road Kolkata"
               )
        XCTAssertTrue(user.isValidUserName())
    }
    
    func testUserFirstName_shouldPassIfUserNameLengthLessThanMin(){
        user = PojoClass(userName: "A", lastName: "Charan", email: "dey@test.com", phoneNumber: 0788222153, address: "3C Albert road Kolkata"
               )
        XCTAssertFalse(user.isValidUserName())
    }
    
    func testUserFirstName_shouldPassIfUserNameHasSpace(){
        user = PojoClass(userName: "Abhay Das", lastName: "Charan", email: "dey@test.com", phoneNumber: 0788222153, address: "3C Albert road Kolkata"
               )
        XCTAssertFalse(user.isValidUserName())
    }
    
    func testUserLastName_shouldPassIfValidLastName(){
        user = PojoClass(userName: "Abhay", lastName: "Charan", email: "dey@test.com", phoneNumber: 0788222153, address: "3C Albert road Kolkata"
        )
        XCTAssertTrue(user.isValidLastName())
    }
    
    func testUserLastName_shouldPassIfLastNameLengthLessThanMin(){
        user = PojoClass(userName: "Abhay", lastName: "", email: "dey@test.com", phoneNumber: 0788222153, address: "3C Albert road Kolkata"
        )
        XCTAssertFalse(user.isValidLastName())
    }
    
    
    func testEmail_shouldPassIfValidEmail(){
        user = PojoClass(userName: "Abhay", lastName: "Charan", email: "dey@test.com", phoneNumber: 0788222153, address: "3C Albert road Kolkata"
               )
        XCTAssertTrue(user.isValidEmail())
    }
    
    func testEmail_shouldPassIfEmailAtSignMissing(){
        user = PojoClass(userName: "Abhay", lastName: "Charan", email: "deytest.com", phoneNumber: 0788222153, address: "3C Albert road Kolkata"
        )
        XCTAssertFalse(user.isValidEmail())
    }
    
    func testEmail_shouldPassIfEmailDotMissing(){
        user = PojoClass(userName: "Abhay", lastName: "Charan", email: "dey@test", phoneNumber: 0788222153, address: "3C Albert road Kolkata"
        )
        XCTAssertFalse(user.isValidEmail())
    }
    
    func testEmail_shouldPassIfEmailContainsSpace(){
        user = PojoClass(userName: "Abhay", lastName: "Charan", email: "dey@ test", phoneNumber: 0788222153, address: "3C Albert road Kolkata"
        )
        XCTAssertFalse(user.isValidEmail())
    }
    
    func testPhoneNumber_shouldPassIfValidPhoneNumber(){
        user = PojoClass(userName: "Abhay", lastName: "Charan", email: "dey@test.com", phoneNumber: 0788222153, address: "3C Albert road Kolkata"
               )
        XCTAssertTrue(user.isValidPhoneNumber())
    }
    
    
    func testPhoneNumber_shouldPassIfPhoneNumberLengthLessThanMin(){
        user = PojoClass(userName: "Abhay", lastName: "Charan", email: "dey@test.co.in", phoneNumber: 023, address: "3C Albert road Kolkata"
        )
        XCTAssertFalse(user.isValidPhoneNumber())
    }
    
    func testAddress_shouldPassIfValidPAddress(){
        user = PojoClass(userName: "Abhay", lastName: "Charan", email: "dey@test.com", phoneNumber: 0788222153, address: "3C Albert road Kolkata"
               )
        XCTAssertTrue(user.isValidAddress())
    }
    
    func testAddress_shouldPassIfAddressLengthLessThanMin(){
        user = PojoClass(userName: "Abhay", lastName: "Charan", email: "dey@test.co.in", phoneNumber: 023, address: "3C"
        )
        XCTAssertFalse(user.isValidAddress())
    }
    
    //MARK:Test overall data validity
    func testData(){
        user = PojoClass(userName: "Abhay", lastName: "Charan", email: "dey@test.co.in", phoneNumber: 0788222153, address: "3C Albert road Kolkata"
        )
        XCTAssertTrue(user.isDataValid())
    }
    
    

}
