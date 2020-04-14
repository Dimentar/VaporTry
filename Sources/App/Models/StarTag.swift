//
//  StarTag.swift
//  App
//
//  Created by dimentar on 20/03/2020.
//

import Foundation
import Vapor
import Fluent

final class StarTag: Model, Content {
    static var schema: String = "star_tag"
    
    @ID(key: .id)
    var id: UUID?
    
    @Parent(key: .tagId)
    var tag: Tag
    
    @Parent(key: .starId)
    var star: Star

    init() {}

    public init(tagId: UUID, starId: UUID) {
        self.$tag.id = tagId
        self.$star.id = starId
    }
}
