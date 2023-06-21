//
//  Toast.swift
//  ToDoList
//
//  Created by Azfar Imtiaz on 2023-06-21.
//
import SwiftUI

struct Toast: ViewModifier {
    @Binding var isPresented: Bool
    let message: String
    
    
    func body(content: Content) -> some View {
        ZStack {
            content
            Group {
                if isPresented {
                   
                    GeometryReader { geo in
                        VStack {
                            Spacer()
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
