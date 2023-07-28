//
//  ToDoListItem.swift
//  ToDoList
//
//  Created by Azfar Imtiaz on 2023-06-15.
//

import Foundation

struct ToDoListItem: Codable, Identifiable {
    let id: String
    let title: String
    let dueDate: TimeInterval
    let createdDate: TimeInterval
    var completedDate: TimeInterval
    var isDone: Bool
    
    mutating func setTaskAsDone(_ state: Bool) {
        isDone = state
        if state {
            completedDate = Date().timeIntervalSince1970
        } else {
            completedDate = Date(timeIntervalSince1970: createdDate).addingTimeInterval(-86400).timeIntervalSince1970
        }
        print("Completed date is: \(Date(timeIntervalSince1970: completedDate))")
    }
}
