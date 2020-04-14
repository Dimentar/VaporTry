import Fluent

struct TodoMigration {
    struct V00: Migration {
        var name: String = "Todo.Migration.V00"
        
        func prepare(on database: Database) -> EventLoopFuture<Void> {
            return database.schema(Todo.schema)
                .id()
                .field("title", .string, .required)
                .field("message", .string, .required)
                .create()
        }
        
        func revert(on database: Database) -> EventLoopFuture<Void> {
            return database.schema(Todo.schema).delete()
        }
    }
}
