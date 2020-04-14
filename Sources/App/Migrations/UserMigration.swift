//
//  UserMigration.swift
//  App
//
//  Created by dimentar on 21/03/2020.
//

import Foundation
import Fluent

struct UserMigration {
    struct V00: Fluent.Migration {
        var name: String { "User.Migration.V00" }
        
        func prepare(on database: Database) -> EventLoopFuture<Void> {
            database.schema(User.schema)
                .id()
                .field(.name, .string, .required)
                .field("email", .string, .required)
                .field("password_hash", .string, .required)
                .create()
        }

        func revert(on database: Database) -> EventLoopFuture<Void> {
            database.schema(User.schema).delete()
        }
    }
}
