import Fluent
import Vapor

struct GalaxyController {
    func index(req: Request) throws -> EventLoopFuture<[Galaxy]> {
        Galaxy.query(on: req.db)
            .with(\.$stars)
            .all()
    }
    
    func show(req: Request) throws -> EventLoopFuture<Galaxy> {
        Galaxy.find(req.parameters.get("id"), on: req.db)
            .unwrap(or: Abort(.notFound))
    }

    func create(req: Request) throws -> EventLoopFuture<Galaxy> {
        let model = try req.content.decode(Galaxy.self)
        return model.create(on: req.db).map { model }
    }

    func update(req: Request) throws -> EventLoopFuture<Galaxy> {
        let model = try req.content.decode(Galaxy.self)
        return model.update(on: req.db).map { model }
    }

    func delete(req: Request) throws -> EventLoopFuture<HTTPStatus> {
        Galaxy.find(req.parameters.get("id"), on: req.db)
            .unwrap(or: Abort(.notFound))
            .flatMap { $0.delete(on: req.db) }
            .map { _ in .ok }
    }
}
