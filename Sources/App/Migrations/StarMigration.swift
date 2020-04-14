//
//  StarMigration.swift
//  App
//
//  Created by dimentar on 20/03/2020.
//

import Foundation
import Fluent

struct StarMigration {
    struct V00: Migration {
        var name: String = "Star.Migration.V00"
        
        func prepare(on database: Database) -> EventLoopFuture<Void> {
            return database.eventLoop.flatten([
                database.schema(Star.schema)
                    .id()
                    .field(.name, .string)
                    .field(.galaxyId, .uuid, .references(Galaxy.schema, .id, onDelete: DatabaseSchema.ForeignKeyAction.cascade, onUpdate: DatabaseSchema.ForeignKeyAction.noAction))
                    .create()
            ])
        }
        
        func revert(on database: Database) -> EventLoopFuture<Void> {
            database.schema(Star.schema).delete()
        }
    }
}
