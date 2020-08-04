import UIKit

class BooksTableViewController: UITableViewController {
    
    //MARK: Properties
    private var books = [Book]()
    private var book = Book()
    private var bookCell = BooksTableViewCell()
    private let azureBooksURL = "https://fakerestapi.azurewebsites.net/api/Books"
    //private var networkManager = NetworkManager()
    
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
        
        // Configure the cell...
        let cell = bookCell.configure(tableView, indexPath, books) as! BooksTableViewCell

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
                self.reloadTableView()
            }
        }
        task.resume()
    }
    
    func reloadTableView(){
        OperationQueue.main.addOperation {
            self.tableView.reloadData()
        }
    }

    //JSON parcing
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
