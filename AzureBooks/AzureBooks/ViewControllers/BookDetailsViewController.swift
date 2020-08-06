import UIKit

class BookDetailsViewController: UIViewController {

    //MARK: Properties
    
    @IBOutlet weak private var IdLabel: UILabel!
    @IBOutlet weak private var titleLabel: UILabel!
    @IBOutlet weak private var pageCountLabel: UILabel!
    @IBOutlet weak private var publishDateLabel: UILabel!
    @IBOutlet weak private var descriptionLabel: UILabel!
    @IBOutlet weak private var excerptLabel: UILabel!
    
    var book: Book?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        IdLabel.text = "\(book?.id ?? 0)"
        titleLabel.text = book?.title
        pageCountLabel.text = "\(book?.pageCount ?? 0)"
        publishDateLabel.text = book?.publishDate
        descriptionLabel.text = book?.description
        excerptLabel.text = book?.excerpt
    }
   
}
