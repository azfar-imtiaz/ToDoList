//
//  ProfileView.swift
//  ToDoList
//
//  Created by Azfar Imtiaz on 2023-06-15.
//

import SwiftUI

struct ProfileView: View {
    @StateObject var viewModel = ProfileViewViewModel()
    var body: some View {
        NavigationView {
            VStack {
                if let user = viewModel.user {
                    profile(user: user)
                } else {
                    TLButton(title: "Log Out", backgroundColor: .red, action: viewModel.logOut)
                        .frame(width: 200, height: 70, alignment: .bottom)
                        .padding()
                    Text("Loading user...")
                }
            }
            .navigationTitle("Profile")
        }
        .onAppear {
            viewModel.fetchUser()
        }
    }
    
    @ViewBuilder
    func profile(user: User) -> some View {
        // Avatar
        Image(systemName: "person.circle")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .foregroundColor(.blue)
            .frame(width: 125, height: 125)
            .padding()
        
        // Info: Name, Email, Member since
        VStack(alignment: .leading) {
            HStack {
                Text("Name: ")
                    .bold()
                Spacer()
                Text(user.name)
            }
            .padding()
            HStack {
                Text("Email Address: ")
                    .bold()
                Spacer()
                Text(user.emailAddress)
            }
            .padding()
            HStack {
                Text("Member since: ")
                    .bold()
                Spacer()
                Text("\(Date(timeIntervalSince1970: user.joinDate).formatted(date: .abbreviated, time: .shortened))")
            }
            .padding()
        }
        .padding()
        
        // Sign out button
        TLButton(title: "Log Out", backgroundColor: .red, action: viewModel.logOut)
            .frame(width: 200, height: 70, alignment: .bottom)
            .padding()
        
        Spacer()
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
