import Fluent
import Vapor

final class Todo: Model, Content {
    static let schema = "todos"
    
    @ID(key: .id)
    var id: UUID?

    @Field(key: "title")
    var title: String

    @Field(key: "message")
    var message: String

    init() { }

    init(id: UUID? = nil, title: String, message: String) {
        self.id = id
        self.title = title
        self.message = message
    }
}
