import UIKit

class BookDetailsViewController: UIViewController {

    //MARK: Properties
    
    @IBOutlet weak var IdLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var pageCountLabel: UILabel!
    @IBOutlet weak var publishDateLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var excerptLabel: UILabel!
    
    var book = Book()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        IdLabel.text = "\(book.id)"
        titleLabel.text = book.title
        pageCountLabel.text = "\(book.pageCount)"
        publishDateLabel.text = book.publishDate
        descriptionLabel.text = book.description
        excerptLabel.text = book.excerpt
    }
   
}
