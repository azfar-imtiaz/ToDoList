//
//  TaskCompletionViewViewModel.swift
//  ToDoList
//
//  Created by Azfar Imtiaz on 2023-07-27.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth

class TaskCompletionViewViewModel: ObservableObject {
    @Published var completionPercentage: Double = -1.0
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
                        if isDone {
                            completedTasks += 1
                        }
                        totalTasks += 1
                    } catch {
                        print("The following exception occurred: \(error)")
                    }
                }
                self.completionPercentage = (completedTasks / totalTasks) * 100.0
            }
        }
    }
}
