//
//  Galaxy.swift
//  App
//
//  Created by dimentar on 20/03/2020.
//

import Foundation
import Vapor
import Fluent

final class Galaxy: Model, Content {
    static var schema: String = "galaxies"
    
    @ID(key: .id)
    var id: UUID?
    
    @Field(key: .name)
    var name: String
    
    @Children(for: \.$galaxy)
    var stars: [Star]
    
    @Timestamp(key: .createdAt, on: .create)
    var createdAt: Date?

    @Timestamp(key: .updatedAt, on: .update)
    var updatedAt: Date?

    init() {}

    init(id: UUID? = nil, name: String) {
        self.id = id
        self.name = name
    }
}
