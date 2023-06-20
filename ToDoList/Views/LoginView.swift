//
//  LoginView.swift
//  ToDoList
//
//  Created by Azfar Imtiaz on 2023-06-15.
//

import SwiftUI

struct LoginView: View {
    
    @StateObject var viewModel = LoginViewViewModel()
    
    var body: some View {
        VStack {
            // Header
            HeaderView(title: "To Do List", subTitle: "Get things done!", background: Color.pink)
            
            // Login form
            Form {
                if !viewModel.errorMessage.isEmpty {
                    Text(viewModel.errorMessage)
                        .foregroundColor(Color.red)
                }
                
                TextField("Email Address", text: $viewModel.email)
                    .textFieldStyle(DefaultTextFieldStyle())
                    .autocapitalization(.none)
                SecureField("Password", text:$viewModel.password)
                    .textFieldStyle(DefaultTextFieldStyle())
                
                TLButton(title: "Log In", backgroundColor: Color.blue) {
                    viewModel.login()
                }
            }
            .offset(y: -50)
            
//            // Create account
            VStack {
                Text("New around here?")
                NavigationLink("Create an account", destination: RegisterView())
            }
            .padding(.bottom, 20)
            .padding(.top, 20)

            Spacer()
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
