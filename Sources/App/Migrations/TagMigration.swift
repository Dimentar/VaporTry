//
//  TagMigration.swift
//  App
//
//  Created by dimentar on 20/03/2020.
//

import Foundation
import Fluent

struct TagMigration {
    struct V00: Migration {
        var name: String = "Tag.Migration.V00"
        func prepare(on database: Database) -> EventLoopFuture<Void> {
            database.schema(Tag.schema)
                .id()
                .field(.name, .string)
                .create()
        }
        
        func revert(on database: Database) -> EventLoopFuture<Void> {
            database.schema(Tag.schema).delete()
        }
    }
}
