import Fluent
import Vapor

struct TodoController {
    func index(req: Request) throws -> EventLoopFuture<[Todo]> {
        return Todo.query(on: req.db).all()
    }
    
    func show(req: Request) throws -> EventLoopFuture<Todo> {
        return Todo.find(req.parameters.get("todoID"), on: req.db)
            .unwrap(or: Abort(.notFound))
    }

    func create(req: Request) throws -> EventLoopFuture<Todo> {
        let todo = try req.content.decode(Todo.self)
        return todo.save(on: req.db).map { todo }
    }

    func update(req: Request) throws -> EventLoopFuture<Todo> {
        let todo = try req.content.decode(Todo.self)
        return todo.update(on: req.db)
            .map { todo }
    }

    func delete(req: Request) throws -> EventLoopFuture<HTTPStatus> {
        return Todo.find(req.parameters.get("todoID"), on: req.db)
            .unwrap(or: Abort(.notFound))
            .flatMap { $0.delete(on: req.db) }
            .map { _ in .ok }
    }
}
