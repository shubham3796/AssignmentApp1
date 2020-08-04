import UIKit

class BookDetailsView: UIView {
    private var book: Book
    private var bookDetailsViewController = .instantiateViewControllerWithIdentifier("BookDetails") as! BookDetailsViewController

    required init?(coder: NSCoder) {
        
    }
  
}
