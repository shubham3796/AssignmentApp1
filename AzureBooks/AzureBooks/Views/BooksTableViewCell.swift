import UIKit

class BooksTableViewCell: UITableViewCell {
    
    //MARK: Properties
    @IBOutlet weak private var bookNameLabel: UILabel!
    
    @IBOutlet weak private var descriptionLabel: UILabel!
   
    //MARK: Functions
    func configure(_ tableView: UITableView, _ indexPath: IndexPath, _ books:[Book]) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "BookCell", for: indexPath) as! BooksTableViewCell
        cell.bookNameLabel.text = books[indexPath.row].title
        cell.descriptionLabel.text = books[indexPath.row].description
        return cell
    }

}
