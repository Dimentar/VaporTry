import Fluent
import Vapor

func routes(_ app: Application) throws {
    app.get { req in
        return "It works!"
    }
    
    app.get("hello") { req in
        return "Hello, world!"
    }

    // Todo
    let todoController = TodoController()
    app.get("todos", use: todoController.index)
    app.get("todos", ":id", use: todoController.show)
    app.post("todos", use: todoController.create)
    app.put("todos", use: todoController.update)
    app.on(.DELETE, "todos", ":id", use: todoController.delete)
    
    // Galaxies
    let galaxyController = GalaxyController()
    app.get("galaxies", use: galaxyController.index)
    app.get("galaxies", ":id", use: galaxyController.show)
    app.post("galaxies", use: galaxyController.create)
    app.put("galaxies", use: galaxyController.update)
    app.delete("galaxies", ":id", use: galaxyController.delete)
    
    app.get("galaxies", "new") { req -> EventLoopFuture<Galaxy> in
        let galaxy = Galaxy(name: "Milky Way")
        return galaxy.create(on: req.db)
            .map { galaxy }
    }
    
    // Stars
    app.get("stars") { req in
        Star.query(on: req.db).with(\.$tags).all()
    }
    app.post("stars") { req -> EventLoopFuture<Star> in
        let star = try req.content.decode(Star.self)
        return star.create(on: req.db).map { star }
    }
    app.get("stars", "new") { req -> EventLoopFuture<Star> in
        Galaxy.query(on: req.db).all()
            .map { $0.first?.id }
            .unwrap(or: Abort(.notFound))
            .flatMap {
                let star = Star(name: "Sun", galaxyId: $0)
                return star.create(on: req.db).map { star }
            }
    }
    
    // StarTags
    app.post("star", ":starID", "tag", ":tagID") { req -> EventLoopFuture<HTTPStatus> in
        let star = Star.find(req.parameters.get("starID"), on: req.db)
            .unwrap(or: Abort(.notFound))
        let tag = Tag.find(req.parameters.get("tagID"), on: req.db)
            .unwrap(or: Abort(.notFound))
        return star.and(tag).flatMap { (star, tag) in
            star.$tags.attach(tag, on: req.db)
        }.transform(to: .ok)
    }
    
    /// Redirect
    app.get("redirect") { req in
        req.redirect(to: "http://vapor.codes")
    }
    
    app.get("client") { req in
        app.client.get("http://vapor.codes")
    }
    
    // Users
    app.post("users") { req -> EventLoopFuture<User> in
        try User.Create.validate(req)
        let create = try req.content.decode(User.Create.self)
        guard create.password == create.confirmPassword else {
            throw Abort(.badRequest, reason: "Passwords did not match")
        }
        let user = try User(
            name: create.name,
            email: create.email,
            passwordHash: Bcrypt.hash(create.password)
        )
        return user.save(on: req.db).map { user }
    }
    
    // Login
    
    let passwordProtected = app.grouped(User.authenticator())
    
    passwordProtected.post("login") { req -> EventLoopFuture<UserToken> in
        let user = try req.auth.require(User.self)
        let token = try user.generateToken()
        
        return token.save(on: req.db)
            .map { token }
    }
    
    let tokenProtected = app.grouped(UserToken.authenticator())
    
    tokenProtected.get("me") { req -> User in
        try req.auth.require(User.self)
    }
}
