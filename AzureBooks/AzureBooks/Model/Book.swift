import Foundation

struct Book: Codable{
    let id: Int
    let title: String
    let description: String
    let pageCount: Int
    let excerpt: String
    let publishDate: String
    
    
    enum CodingKeys: String, CodingKey {
        case id = "ID"
        case title = "Title"
        case description = "Description"
        case pageCount = "PageCount"
        case excerpt = "Excerpt"
        case publishDate = "PublishDate"
    }
    
    init(id: Int, title: String, description: String, pageCount: Int, excerpt: String, publishDate: String){
        self.id = id
        self.title = title
        self.description = description
        self.pageCount = pageCount
        self.excerpt = excerpt
        self.publishDate = publishDate
    }
   
}
