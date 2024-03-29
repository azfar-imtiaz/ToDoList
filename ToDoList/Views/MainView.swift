//
//  ContentView.swift
//  ToDoList
//
//  Created by Azfar Imtiaz on 2023-06-15.
//

import SwiftUI

struct MainView: View {
    @StateObject var viewModel = MainViewViewModel()
    
    var body: some View {
        NavigationView {
            if viewModel.isSignedIn, !viewModel.currentUserId.isEmpty {
                // signed in state
                accountView
            } else {
                LoginView()
            }
        }
    }
    
    @ViewBuilder
    var accountView: some View {
        TabView {
            ToDoListView(userID: viewModel.currentUserId)
                .tabItem {
                    Label("Home", systemImage: "house")
                }
            TaskCompletionView(userID: viewModel.currentUserId)
                .tabItem {
                    Label("Completion", systemImage: "percent")
                }
            ProfileView()
                .tabItem {
                    Label("Profile", systemImage: "person.circle")
                }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
