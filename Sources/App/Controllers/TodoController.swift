import Fluent
import Vapor

struct TodoController {
    func index(req: Request) throws -> EventLoopFuture<[Todo]> {
        Todo.query(on: req.db).all()
    }
    
    func show(req: Request) throws -> EventLoopFuture<Todo> {
        Todo.find(req.parameters.get("id"), on: req.db)
            .unwrap(or: Abort(.notFound))
    }

    func create(req: Request) throws -> EventLoopFuture<Todo> {
        let model = try req.content.decode(Todo.self)
        return model.save(on: req.db).map { model }
    }

    func update(req: Request) throws -> EventLoopFuture<Todo> {
        let model = try req.content.decode(Todo.self)
        return model.update(on: req.db).map { model }
    }

    func delete(req: Request) throws -> EventLoopFuture<HTTPStatus> {
        Todo.find(req.parameters.get("id"), on: req.db)
            .unwrap(or: Abort(.notFound))
            .flatMap { $0.delete(on: req.db) }
            .map { _ in .ok }
    }
}
