//
//  UserTokenMigration.swift
//  App
//
//  Created by dimentar on 21/03/2020.
//

import Foundation
import Fluent

struct UserTokenMigration {
    struct V00: Migration {
        var name: String { "UserToken.Migration.V00" }

        func prepare(on database: Database) -> EventLoopFuture<Void> {
            database.schema(UserToken.schema)
                .id()
                .field(.value, .string, .required)
                .field(.userId, .uuid, .required, .references(User.schema, .id, onDelete: DatabaseSchema.ForeignKeyAction.cascade, onUpdate: DatabaseSchema.ForeignKeyAction.noAction))
                .unique(on: .value)
                .create()
        }

        func revert(on database: Database) -> EventLoopFuture<Void> {
            database.schema(UserToken.schema).delete()
        }
    }
}
