//
//  LoginView.swift
//  ToDoList
//
//  Created by Azfar Imtiaz on 2023-06-15.
//

import SwiftUI

struct LoginView: View {
    
    @State var email = ""
    @State var password = ""
    
    var body: some View {
        VStack {
            // Header
            HeaderView()
            
            // Login form
            Form {
                TextField("Email Address", text: $email)
                    .textFieldStyle(DefaultTextFieldStyle())
                SecureField("Password", text:$password)
                    .textFieldStyle(DefaultTextFieldStyle())
                
                Button("Log In", action: {
                    // attempt log in
                })
                .bold()
                .buttonStyle(.borderedProminent)
                .padding(.vertical, 5)
                .frame(maxWidth: .infinity)
                .controlSize(.regular)
                
//                Button {
//                    // attempt log in
//                } label: {
//                    ZStack {
//                        RoundedRectangle(cornerRadius: 10)
//                            .foregroundColor(Color.blue)
//
//                        Text("Log In")
//                            .foregroundColor(Color.white)
//                            .bold()
//                    }
//                }
//                .padding(.vertical, 10)
            }
            
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
