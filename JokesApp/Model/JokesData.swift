//
//  JokesModel.swift
//  JokesApp
//
//  Created by Desiree on 10/13/20.
//

import Foundation

struct Joke: Codable {
    let id: Int
    let type: String
    let setup: String
    let punchline: String
    
}

struct JokesData: Codable {
    let jokes: [Joke]
}
