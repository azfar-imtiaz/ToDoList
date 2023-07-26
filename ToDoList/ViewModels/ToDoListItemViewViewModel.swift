//
//  ToDoListItemViewViewModel.swift
//  ToDoList
//
//  Created by Azfar Imtiaz on 2023-06-15.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

/// ViewModel for single to do list item view (each row in items list)
class ToDoListItemViewViewModel: ObservableObject {
    init() {}
    
    func toggleIsDone(item: ToDoListItem) {
        // we create a copy because item is passed as value here; it is immutable
        var copyItem = item
        copyItem.setTaskAsDone(!item.isDone)
        
        guard let userID = Auth.auth().currentUser?.uid else {
            return
        }
        
        let db = Firestore.firestore()
        db.collection("users")
            .document(userID)
            .collection("ToDos")
            .document(copyItem.id)
            .updateData(copyItem.asDictionary())
    }
}
