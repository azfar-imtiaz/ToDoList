//
//  User.swift
//  ToDoList
//
//  Created by Azfar Imtiaz on 2023-06-15.
//

import Foundation

struct User: Codable {
    let id: String
    let name: String
    let emailAddress: String
    let joinDate: TimeInterval
}
