//
//  RegisterViewViewModel.swift
//  ToDoList
//
//  Created by Azfar Imtiaz on 2023-06-15.
//

import Foundation

class RegisterViewViewModel: ObservableObject {
    @Published var name = ""
    @Published var emailAddress = ""
    @Published var password = ""
    
    init() {}
}
