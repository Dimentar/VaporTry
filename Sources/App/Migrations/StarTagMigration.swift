//
//  StarTagMigration.swift
//  App
//
//  Created by dimentar on 20/03/2020.
//

import Foundation
import Fluent

struct StarTagMigration {
    struct V00: Migration {
        var name: String = "StarTag.Migration.V00"
        
        func prepare(on database: Database) -> EventLoopFuture<Void> {
            database.schema(StarTag.schema)
                .id()
                .field(.starId, .uuid, .required, .references(Star.schema, .id, onDelete: DatabaseSchema.ForeignKeyAction.cascade, onUpdate: DatabaseSchema.ForeignKeyAction.noAction))
                .field(.tagId, .uuid, .required, .references(Tag.schema, .id, onDelete: DatabaseSchema.ForeignKeyAction.cascade, onUpdate: DatabaseSchema.ForeignKeyAction.noAction))
                .create()
        }
        
        func revert(on database: Database) -> EventLoopFuture<Void> {
            database.schema(StarTag.schema).delete()
        }
    }
}
