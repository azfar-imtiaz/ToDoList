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
    
    init() {}
    
    func save() {
        
    }
}
