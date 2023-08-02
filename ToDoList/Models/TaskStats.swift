//
//  TaskStats.swift
//  ToDoList
//
//  Created by Azfar Imtiaz on 2023-08-02.
//

import Foundation

struct TaskStats: Codable {
    let totalTasks: Int
    let completedTasks: Int
    let completedOnTimeTasks: Int
}
