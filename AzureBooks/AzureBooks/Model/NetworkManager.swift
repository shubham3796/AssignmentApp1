import Foundation

class NetworkManager{
    //MARK: Properties
    private let azureBooksURL = "https://fakerestapi.azurewebsites.net/api/Books"
    private var books = [Book]()
    private let notificationCenter = NotificationCenter.default
    
   // DATA FETCHING
    //MARK: API calling
    func getBooks() {
        guard let booksUrl = URL(string: azureBooksURL) else{
            return
        }
        var postRequest = URLRequest(url: booksUrl)
        postRequest.httpMethod = "GET"
        let task = URLSession.shared.dataTask(with: postRequest) { (data, response, error) in
            
            if let error = error {
                print(error)
                return
            }
            
            //Parse JSON data
            if let data = data{
                self.books = self.parseJsonData(data: data)
                NotificationCenter.default.post(name: Notification.Name(rawValue: "booksFetching"), object: nil, userInfo: ["fetchedBooks":self.books])
            }
        }
        task.resume()
    }

    //MARK: JSON parcing
    func parseJsonData(data: Data) -> [Book]{
        var booksList = [Book]()
        
        let decoder = JSONDecoder()
        
        do{
            booksList = try decoder.decode([Book].self, from: data)
        } catch {
            print(error)
        }
        return booksList
        
    }

}

