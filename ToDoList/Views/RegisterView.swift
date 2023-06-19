//
//  RegisterView.swift
//  ToDoList
//
//  Created by Azfar Imtiaz on 2023-06-15.
//

import SwiftUI

struct RegisterView: View {
    var body: some View {
        @State var viewModel = RegisterViewViewModel()
        
        VStack {
            HeaderView(title: "Register", subTitle: "Start organizing your to-dos!", background: Color.orange)
                .offset(y: -37)
            
            Form {
                TextField("Full name", text: $viewModel.name)
                    .textFieldStyle(DefaultTextFieldStyle())
                    .autocorrectionDisabled(true)
                TextField("Email address", text: $viewModel.emailAddress)
                    .textFieldStyle(DefaultTextFieldStyle())
                    .autocapitalization(.none)
                    .autocorrectionDisabled()
                SecureField("Password", text: $viewModel.password)
                    .textFieldStyle(DefaultTextFieldStyle())
                
                TLButton(title: "Create Account", backgroundColor: Color.green) {
                    // attempt registration
                }
            }
            .offset(y: -60)
            
            Spacer()
        }
            
        
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}
