import UIKit

class BooksTableViewController: UIViewController {
    
    //MARK: Properties
    @IBOutlet private var booksTableView: UITableView!
    private var bookCell = BooksTableViewCell()
    
    var bookViewModel = BooksTableViewModel(index: 0)
    
    
    //MARK: View life cycles
    override func viewWillAppear(_ animated: Bool) {

        //Fetch books from API
        bookViewModel.getBooks(completion: {booksFetched in
            books = booksFetched
            self.reloadTableView()
        })
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        booksTableView.delegate = self
        booksTableView.dataSource = self
    }
    
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showBookDetails" {
            if let destinationVC = segue.destination as? BookDetailsViewController {
                destinationVC.book = bookViewModel.presentBook
            }
        }
    }
    //MARK: Custom functions
    func reloadTableView(){
        OperationQueue.main.addOperation {
            self.booksTableView.reloadData()
        }
    }    
}
