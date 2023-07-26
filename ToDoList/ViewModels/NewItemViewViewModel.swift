//
//  NewItemViewViewModel.swift
//  ToDoList
//
//  Created by Azfar Imtiaz on 2023-06-15.
//

import Foundation

class NewItemViewViewModel: ObservableObject {
    @Published var title = ""
    @Published var dueDate = Date()
    @Published var showingAlert = false
    
    init() {}
    
    func save() {
        
    }
    
    var canSave: Bool {
        guard !title.trimmingCharacters(in: .whitespaces).isEmpty else {
            return false
        }
        
        // the .addingTimeInterval(-86400) means we're subtracting a day from today, so basically, yesterday
        // therefore, this check is ensuring that the due date is greater than yesterday. This allows us to select
        //  today as the due date also
        guard dueDate >= Date().addingTimeInterval(-86400) else {
            return false
        }
        
        return true
    }
}
