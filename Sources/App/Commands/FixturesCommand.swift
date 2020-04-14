//
//  FixturesCommand.swift
//  App
//
//  Created by dimentar on 21/03/2020.
//

import Foundation
import Vapor

struct FixturesCommand: Command {
    var help: String = "This command will save fixtures to Database."
    
    struct Signature: CommandSignature {
        @Flag(name: "clean", short: "c", help: "Clean the db")
        var clean: Bool
    }
    
    func run(using context: CommandContext, signature: Signature) throws {
        let app = context.application
        
        app.logger.info("Running Fixtures...")
        
        if signature.clean {
            app.logger.warning("Purging Database...")
            
            try Galaxy.query(on: app.db).delete().wait()
            try User.query(on: app.db).delete().wait()
            
            app.logger.warning("Purging Database OK")
        }

        let galaxy = try createGalaxy(app: app)
        try createStar(app: app, galaxyId: galaxy.id)
        try createUser(app: app)
    }
    
    private func createGalaxy(app: Application) throws -> Galaxy {
        app.logger.notice("Creating Galaxy...")
        
        let galaxy = Galaxy(name: "Milky Way")
        try galaxy.create(on: app.db).wait()
        
        app.logger.notice("Galaxy is ready.")
        
        return galaxy
    }
    
    private func createStar(app: Application, galaxyId: UUID?) throws {
        guard let galaxyId = galaxyId else {
            return app.logger.warning("Galaxy Id not found.")
        }
        
        app.logger.notice("Creating Star...")
        
        let star = Star(name: "Sun", galaxyId: galaxyId)
        try star.save(on: app.db).wait()
        
        app.logger.notice("Star is ready.")
    }
    
    private func createUser(app: Application) throws {
        app.logger.notice("Creating User...")
        
        let user = try User(
            name: "Vapor",
            email: "test@vapor.codes",
            passwordHash: Bcrypt.hash("secret")
        )
        try user.create(on: app.db).wait()
        
        app.logger.notice("User is ready.")
    }
}
