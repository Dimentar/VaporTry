import Fluent
import FluentSQLiteDriver
import Vapor

// Called before your application initializes.
public func configure(_ app: Application) throws {
    // Serves files from `Public/` directory
    // app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))

    // Configure SQLite database
    app.databases.use(.sqlite(.file("db.sqlite")), as: .sqlite)
    app.databases.middleware.use(GalaxyMiddleware(), on: .sqlite)

    // Configure migrations
    app.migrations.add(TodoMigration.V00())
    app.migrations.add(GalaxyMigration.V00())
    app.migrations.add(StarMigration.V00())
    app.migrations.add(TagMigration.V00())
    app.migrations.add(StarTagMigration.V00())
    app.migrations.add(UserMigration.V00())
    app.migrations.add(UserTokenMigration.V00())
    
    // Testing
    try app.autoMigrate().wait()
    
    try routes(app)
    
    /// export EXAMPLE="hello"; swift run Run serve --env production
//    let variable = Environment.get("EXAMPLE") ?? "undefined"
//    print(variable)
//    print(app.environment.name)
//    print(app.environment.arguments)
//    print(app.environment.commandInput)

//    if app.environment.isRelease {
//        print("production mode")
//    }
    
    /// swift run Run serve --env production
    /// # NOTE: toolbox command is not accepting env in the current beta
    /// vapor build && vapor run serve --env production
    
//    print(app.directory.workingDirectory)
//    print(app.directory.publicDirectory)
//    print(app.directory.resourcesDirectory)
//    print(app.directory.viewsDirectory)

    ///
//    app.server.configuration.hostname = "api.example.com"
//    app.server.configuration.port = 8081
    
    /// Commands
    /// Usage: `swift run Run hello world`
    app.commands.use(HelloCommand(), as: "hello")
    app.commands.use(FixturesCommand(), as: "fixtures")
}
