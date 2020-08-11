import Foundation
import UIKit

extension BooksTableViewController: UITableViewDelegate{
    
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       // tableView.deselectRow(at: indexPath, animated: true)
        bookViewModel.index = indexPath.row
        //book = bookViewModel.presentBook
        let cell = tableView.cellForRow(at: indexPath)
        performSegue(withIdentifier: "showBookDetails", sender: cell)
    }
    
}
