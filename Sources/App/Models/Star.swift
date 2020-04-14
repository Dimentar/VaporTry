//
//  Star.swift
//  App
//
//  Created by dimentar on 20/03/2020.
//

import Foundation
import Vapor
import Fluent

final class Star: Model, Content {
    static var schema: String = "stars"
    
    @ID(key: .id)
    var id: UUID?
    
    @Field(key: .name)
    var name: String
    
    @Parent(key: .galaxyId)
    var galaxy: Galaxy
    
    @Siblings(through: StarTag.self, from: \.$star, to: \.$tag)
    var tags: [Tag]

    init() {}

    public init(id: UUID? = nil, name: String, galaxyId: UUID) {
        self.id = id
        self.name = name
        self.$galaxy.id = galaxyId
    }
}
