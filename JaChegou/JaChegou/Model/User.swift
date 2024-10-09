//
//  User.swift
//  AirbnbCloneBootcampProfessor
//
//  Created by Caio Fabrini on 02/10/24.
//

import Foundation

struct User: Codable {
    var id: String
    var email: String
    var name: String
    var password: String
    var birthDate: String
    var track: [Track]
}
