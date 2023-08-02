//
//  TaskCompletionViewViewModel.swift
//  ToDoList
//
//  Created by Azfar Imtiaz on 2023-07-27.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class TaskCompletionViewViewModel: ObservableObject {
    @Published var completionPercentage: Double = -1.0
    @Published var completionOnTimePercentage: Double = -1.0
    @Published var taskStatistics: TaskStats = TaskStats(totalTasks: -1, completedTasks: -1, completedOnTimeTasks: -1)
    private let userID: String
    
    init(userID: String) {
        self.userID = userID
    }
    
    func calculateCompletionPercentage() {
        guard let userID = Auth.auth().currentUser?.uid else {
            return
        }

        var totalTasks = 0.0
        var completedTasks = 0.0
        var completedOnTimeTasks = 0.0
        let db = Firestore.firestore()
        let collection = db.collection("users/\(userID)/ToDos")
        collection.getDocuments { (querySnaphot, err) in
            if let err = err {
                print(err.localizedDescription)
                return
            } else {
                for doc in querySnaphot!.documents {
                    do {
                        let isDone: Bool = try doc.data(as: ToDoListItem.self).isDone
                        let dueDate: TimeInterval = try doc.data(as: ToDoListItem.self).dueDate
                        let completedDate: TimeInterval = try doc.data(as: ToDoListItem.self).completedDate
                        if isDone {
                            completedTasks += 1
                        }
                        if isDone && Date(timeIntervalSince1970: completedDate) <= Date(timeIntervalSince1970: dueDate) {
                            completedOnTimeTasks += 1
                        }
                        totalTasks += 1
                    } catch {
                        print("The following exception occurred: \(error)")
                    }
                }
                self.completionPercentage = (completedTasks / totalTasks) * 100.0
                self.completionOnTimePercentage = (completedOnTimeTasks / totalTasks) * 100.0
                self.taskStatistics = TaskStats(
                    totalTasks: Int(totalTasks),
                    completedTasks: Int(completedTasks),
                    completedOnTimeTasks: Int(completedOnTimeTasks)
                )
            }
        }
    }
}
