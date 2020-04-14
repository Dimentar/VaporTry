//
//  Tag.swift
//  App
//
//  Created by dimentar on 20/03/2020.
//

import Foundation
import Vapor
import Fluent

final class Tag: Model, Content {
    static var schema: String = "tags"
    
    @ID(key: .id)
    var id: UUID?
    
    @Field(key: .name)
    var name: String
    
    @Siblings(through: StarTag.self, from: \.$tag, to: \.$star)
    var stars: [Star]

    init() {}

    public init(id: UUID? = nil, name: String) {
        self.id = id
        self.name = name
    }
}
