//
//  HelloCommand.swift
//  App
//
//  Created by dimentar on 21/03/2020.
//

import Foundation
import Vapor

struct HelloCommand: Command {
    var help: String = "This command will say hello to given name."
    
    struct Signature: CommandSignature {
        @Argument(name: "name", help: "The name to say hello")
        var name: String
    }
    
    func run(using context: CommandContext, signature: Signature) throws {
        print("Hello \(signature.name)")
    }
}
