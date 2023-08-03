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
                HStack {
                    Image("person-icon")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 65, height: 65)
                        .padding()
                        .overlay(Circle()
                            .stroke(lineWidth: 3))
                        .foregroundColor(Color(UIColor.systemBlue))
                    Spacer()
                }
                .padding([.top, .horizontal])
                
                if let user = viewModel.user {
                    Text("Hi, \(user.name)!")
                        .font(.system(.title, design: .rounded)
                            .weight(.semibold))
                        .padding(.vertical)
                    
                    VStack (alignment: .leading) {
                        HStack {
                            Text("Email Address")
                                .fontWeight(.semibold)
                            Spacer()
                            Text("\(user.emailAddress)")
                        }
                        .padding()
                        Divider()
                            .padding(.horizontal)
                        HStack {
                            Text("Member since")
                                .fontWeight(.semibold)
                            Spacer()
                            Text("\(Date(timeIntervalSince1970: user.joinDate).formatted(date: .abbreviated, time: .shortened))")
                        }
                        .padding()
                    }
                    .background(Color(UIColor.systemGroupedBackground))
                    .cornerRadius(8)
                    .padding()
                    Spacer()
                } else {
                    Spacer()
                    VStack {
                        Text("Error loading user information!")
                            .font(.body)
                            .padding()
                    }
                    .background(Color(UIColor.systemGroupedBackground))
                    .cornerRadius(8)
                    .padding(.vertical)
                    Spacer()
                }
                TLButton(title: "Log Out", backgroundColor: .red, action: viewModel.logOut)
                    .frame(
                        width: UIScreen.main.bounds.width * 0.5,
                        height: UIScreen.main.bounds.height * 0.1
                    )
                Spacer()
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
