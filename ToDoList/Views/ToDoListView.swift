//
//  ToDoListView.swift
//  ToDoList
//
//  Created by Azfar Imtiaz on 2023-06-15.
//

import SwiftUI
import FirebaseAuth

struct ToDoListView: View {
    var body: some View {
        VStack {
            Text("Welcome to your account!")
            Button("Log out") {
                try? Auth.auth().signOut()
            }
        }
        
    }
}

struct ToDoListView_Previews: PreviewProvider {
    static var previews: some View {
        ToDoListView()
    }
}
