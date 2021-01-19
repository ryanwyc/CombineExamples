//
//  User.swift
//  CombineExampleOne
//
//  Created by wuyach8 on 2020-11-27.
//

import Foundation

struct User: Codable, Identifiable {
    let id: String
    let firstName: String
    let lastName: String
    var lastLogin: Date?
    var email: String?

    init(id: String = UUID().uuidString, firstName: String, lastName: String, lastLogin: Date? = nil, email: String? = nil) {
        self.id = id
        self.firstName = firstName
        self.lastName = lastName
        self.lastLogin = lastLogin
        self.email = email
    }
}

extension User {
    var fullName: String {
        return "\(firstName) \(lastName)"
    }
}
