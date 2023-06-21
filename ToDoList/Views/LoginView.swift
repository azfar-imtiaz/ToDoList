//
//  LoginView.swift
//  ToDoList
//
//  Created by Azfar Imtiaz on 2023-06-15.
//

import SwiftUI

struct LoginView: View {
    
    @StateObject var viewModel = LoginViewViewModel()
    @ScaledMetric private var padding = 20
    
    
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
        .toast(isPresented: $viewModel.isErrorPresented, message: viewModel.errorMessage)

    }
    
    
    var formView: some View {
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


struct Name: Identifiable {
    var title = ""
    let id = UUID()
}

struct Toast: ViewModifier {
    @Binding var isPresented: Bool
    let message: String
    
    
    let arr = Array(repeating: Name(title: "sarosh"), count: 5)
    
    func body(content: Content) -> some View {
        ZStack {
            content
            Group {
                if isPresented {
                   
                    GeometryReader { geo in
                        VStack {
                            
                            Spacer()
                            ForEach (arr) {i in
                                Text(i.title)
                            }
                            Text(message)
                                .padding(.vertical, 10)
                                .padding(.horizontal, 50)
                                .foregroundColor(.white)
                                .background {
                                    Capsule(style: .circular)
                                        .foregroundColor(.red.opacity(0.9))
                                }
                            Spacer()
                                .frame(height: geo.size.height * 0.25)
                        }
                        .background{
                            Color.clear.ignoresSafeArea()
                        }
                        .onAppear{
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                isPresented = false
                            }
                        }
                        .frame(maxWidth: .infinity, alignment: .center)
                    }
                    .transition(.move(edge: .bottom))
                    .animation(.linear(duration: 0.5), value: isPresented)
                }
            }

            
        }
    }
}

extension View {
    func toast(isPresented: Binding<Bool>, message: String) -> some View {
        modifier(Toast(isPresented: isPresented, message: message))
    }
}
