//
//  ToDoListViewViewModel.swift
//  ToDoList
//
//  Created by Azfar Imtiaz on 2023-06-15.
//

import Foundation
import FirebaseFirestore

/// ViewModel for list of items view
/// Primary tab
class ToDoListViewViewModel: ObservableObject {
    @Published var showingNewItemView = false
    private let userID: String
    
    init(userID: String) {
        self.userID = userID
    }
    
    func delete(itemID: String) {
        let db = Firestore.firestore()
        
        db.collection("users")
            .document(userID)
            .collection("ToDos")
            .document(itemID)
            .delete()
    }
}
