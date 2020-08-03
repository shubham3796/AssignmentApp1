import Foundation

struct Book: Codable{
    var id = 0
    var title = ""
    var description = ""
    var pageCount = 0
    var excerpt = ""
    var publishDate = "2020-07-31T09:35:32.233Z"
    
    
    enum CodingKeys: String, CodingKey {
        case id = "ID"
        case title = "Title"
        case description = "Description"
        case pageCount = "PageCount"
        case excerpt = "Excerpt"
        case publishDate = "PublishDate"
    }
}
