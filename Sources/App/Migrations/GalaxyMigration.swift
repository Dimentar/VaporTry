//
//  GalaxyMigration.swift
//  App
//
//  Created by dimentar on 20/03/2020.
//

import Foundation
import Fluent

struct GalaxyMigration {
    struct V00: Migration {
        var name: String = "Galaxy.Migration.V00"
        
        func prepare(on database: Database) -> EventLoopFuture<Void> {
            database.schema(Galaxy.schema)
                .id()
                .field(.name, .string)
                .field(.createdAt, .datetime)
                .field(.updatedAt, .datetime)
                .field(.deletedAt, .datetime)
                .create()
        }
        
        func revert(on database: Database) -> EventLoopFuture<Void> {
            database.schema(Galaxy.schema).delete()
        }
    }
}
