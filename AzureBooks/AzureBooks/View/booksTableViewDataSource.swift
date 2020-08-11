import Foundation
import UIKit
// MARK: - Table view data source
extension BooksTableViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return books.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Configure the cell...
        let cell = BooksTableViewCell().configure(tableView, indexPath, books ) as! BooksTableViewCell

        return cell
    }
    
    
    
    
}
