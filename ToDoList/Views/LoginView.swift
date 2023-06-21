//
//  LoginView.swift
//  ToDoList
//
//  Created by Azfar Imtiaz on 2023-06-15.
//

import SwiftUI

struct LoginView: View {
    
    @StateObject private var viewModel = LoginViewViewModel()
    @State private var showErrorToast = false
    
    
    var body: some View {
        VStack {
            Spacer()
            formView
            Spacer()
        }
        .background{
            VStack {
                // Header
                HeaderView(title: "To Do List", subTitle: "Get things done!", background: Color.pink)
                Spacer()
                VStack {
                    Text("New around here?")
                    NavigationLink("Create an account", destination: RegisterView())
                }
                .padding(.bottom)
                .padding(.top)
                
            }
        }
        .toast(isPresented: $showErrorToast, message: viewModel.errorMessage)
        .onChange(of: viewModel.isErrorPresented) { newValue in
            if newValue {
                withAnimation {
                    self.showErrorToast.toggle()
                }
            }
        }
    }
    
    
    private var formView: some View {
        Group {
            VStack {
                TextField("Email Address", text: $viewModel.email)
                    .textFieldStyle(DefaultTextFieldStyle())
                    .autocapitalization(.none)
                    .padding([.horizontal, .top])
                Color.gray
                    .opacity(0.25)
                    .frame(maxWidth: .infinity)
                    .frame(height: 1)
                    .padding(.horizontal)
                SecureField("Password", text:$viewModel.password)
                    .textFieldStyle(DefaultTextFieldStyle())
                    .padding([.horizontal])
                Color.gray
                    .opacity(0.25)
                    .frame(maxWidth: .infinity)
                    .frame(height: 1)
                    .padding(.horizontal)
                
                TLButton(title: "Log In", backgroundColor: Color.blue) {
                    viewModel.login()
                }
                Spacer().frame(height: 10)
            }
            .background{
                Color.white
                    .cornerRadius(4)
            }
            .padding()
            
            
        }
        .background {
            Color.gray
                .opacity(0.25)
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
