import Foundation

var books = [Book]()

class BooksTableViewModel{
    //MARK: Properties
    private let azureBooksURL = "https://fakerestapi.azurewebsites.net/api/Books"

    var index: Int
    
    init(index: Int){
        self.index = index
    }
    
    public var presentBook: Book{
        return books[index]
    }
    
    public var id: String{
        return "\(books[index].id)"
    }
    
    public var title: String{
        return books[index].title
    }
    
    public var description: String{
        return books[index].description
    }
    
    public var pageCount: String{
        return "\(books[index].pageCount)"
    }
    
    public var excerpt: String{
        return books[index].excerpt
    }
    
    public var publishDate: String{
        return books[index].publishDate
    }
    
    // DATA FETCHING
    //MARK: API calling
    func getBooks(completion: @escaping ([Book])->Void) {
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
                books = self.parseJsonData(data: data)
                completion(books)
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
