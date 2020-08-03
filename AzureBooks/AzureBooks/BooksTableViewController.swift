import UIKit

class BooksTableViewController: UITableViewController {
    
    private let azureBooksURL = "https://fakerestapi.azurewebsites.net/api/Books"
    //"http://fakerestapi.azurewebsites.net/posts/1"
    
    private var books = [Book]()
    private var book = Book()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getBooks()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return books.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "BookCell", for: indexPath) as! BooksTableViewCell

        // Configure the cell...
        cell.bookNameLabel.text = books[indexPath.row].title
        cell.descriptionLabel.text = books[indexPath.row].description
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       // tableView.deselectRow(at: indexPath, animated: true)
        book = books[indexPath.row]
        let cell = tableView.cellForRow(at: indexPath)
        performSegue(withIdentifier: "showBookDetails", sender: cell)
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showBookDetails" {
            if let destinationVC = segue.destination as? BookDetailsViewController {
                destinationVC.book = self.book
                print(book)
            }
        }
    }

    
    
    //MARK: DATA FETCHING
    // API calling
    func getBooks(){
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
                
                //Reload table view
                OperationQueue.main.addOperation {
                    self.tableView.reloadData()
                }
            }
        }
        task.resume()
    }
    
    //JSON parcing
    func parseJsonData(data: Data) -> [Book]{
        var books = [Book]()
        
        do{
            
            let jsonResult = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSArray
            
            //Parse JSON data
            
            //convert NSArray to swift array
            let mutableArrayOfBooks = NSMutableArray(array: jsonResult ?? [])
            let jsonBooks = mutableArrayOfBooks as! [[String:AnyObject]]
            
            for jsonBook in jsonBooks {
                var book = Book()
                book.id = jsonBook["ID"] as! Int
                book.title = jsonBook["Title"] as! String
                book.description = jsonBook["Description"] as! String
                book.excerpt = jsonBook["Excerpt"] as! String
                book.pageCount = jsonBook["PageCount"] as! Int
                book.publishDate = jsonBook["PublishDate"] as! String
                books.append(book)
            }
        } catch{
            print(error)
        }
        return books
    }
    
}
