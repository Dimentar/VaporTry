//
//  UserToken.swift
//  App
//
//  Created by dimentar on 21/03/2020.
//

import Foundation
import Fluent
import Vapor

final class UserToken: Model, Content {
    static var schema: String { "user_tokens" }
    
    @ID(key: .id)
    var id: UUID?

    @Field(key: "value")
    var value: String

    @Parent(key: "user_id")
    var user: User

    init() { }

    init(id: UUID? = nil, value: String, userID: User.IDValue) {
        self.id = id
        self.value = value
        self.$user.id = userID
    }
}

extension UserToken: ModelTokenAuthenticatable {
    static let valueKey = \UserToken.$value
    static let userKey = \UserToken.$user

    ///  If this is false, the token will be deleted from the database and the user will not be authenticated.
    var isValid: Bool {
        true
    }
}
