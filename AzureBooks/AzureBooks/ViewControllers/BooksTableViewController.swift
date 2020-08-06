import UIKit

class BooksTableViewController: UITableViewController {
    
    //MARK: Properties
    private var books = [Book]()
    private var book = Book()
    private var bookCell = BooksTableViewCell()
    private var networkManager = NetworkManager()
    
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: "booksFetching"),
                                               object: nil,
                                               queue: nil,
                                               using: doOnFetchingBooks)
        //Fetch books from API
        networkManager.getBooks()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK: Handle Notification
    func doOnFetchingBooks(notification:Notification){
        guard let fetchedBooks = notification.userInfo!["fetchedBooks"] else {return}
        self.books = fetchedBooks as! [Book]
        self.reloadTableView()
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

    func reloadTableView(){
        OperationQueue.main.addOperation {
            self.tableView.reloadData()
        }
    }    
}
