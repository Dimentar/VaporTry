//
//  FieldKey+Extension.swift
//  App
//
//  Created by dimentar on 21/03/2020.
//

import Fluent

extension FieldKey {
    static var title: FieldKey { "title" }
    static var name: FieldKey { "name" }
    static var value: FieldKey { "value" }
    
    static var galaxyId: FieldKey { "galaxy_id" }
    static var starId: FieldKey { "star_id" }
    static var tagId: FieldKey { "tag_id" }
    
    static var userId: FieldKey { "user_id" }
    
    static var createdAt: FieldKey { "created_at" }
    static var updatedAt: FieldKey { "updated_at" }
    static var deletedAt: FieldKey { "deleted_at" }
}
