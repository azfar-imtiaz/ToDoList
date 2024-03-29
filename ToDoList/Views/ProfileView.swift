//
//  ProfileView.swift
//  ToDoList
//
//  Created by Azfar Imtiaz on 2023-06-15.
//

// Icons from:
//  <a target="_blank" href="https://icons8.com/icon/23313/denied">Denied</a> icon by <a target="_blank" href="https://icons8.com">Icons8</a>
//  <a target="_blank" href="https://icons8.com/icon/AaQ0GwIZEy82/tidy-up-skin-type-4">Tidy Up Skin Type 4</a> icon by <a target="_blank" href="https://icons8.com">Icons8</a>

import SwiftUI

struct ProfileView: View {
    @StateObject var viewModel = ProfileViewViewModel()
    var body: some View {
        NavigationView {
            VStack {
                if let user = viewModel.user {
                    profile(user: user)
                } else {
                    noProfile
                }
                // Log out button
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
        HStack {
            // Avatar
            Image("person-icon-tidy-up")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 65, height: 65)
                .padding()
                .overlay(Circle()
                    .stroke(lineWidth: 3)
                    .opacity(0.4))
                .foregroundColor(Color(UIColor.systemBlue))
            Spacer()
        }
        .padding([.top, .horizontal])
    
        // Name
        Text("Hi, \(user.name)!")
            .font(.system(.title, design: .rounded)
                .weight(.semibold))
            .padding(.vertical)
        
        // Information: Email, join date, membership period
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
                Text("Joining Date")
                    .fontWeight(.semibold)
                Spacer()
                Text("\(Date(timeIntervalSince1970: user.joinDate).formatted(date: .abbreviated, time: .omitted))")
            }
            .padding()
            if viewModel.registeredDays > 0 {
                Divider().padding(.horizontal)
                HStack {
                    Text("Membership Period")
                        .fontWeight(.semibold)
                    Spacer()
                    Text("\(viewModel.registeredDays) days")
                }
                .padding()
            }
        }
        .background(Color(UIColor.systemGroupedBackground))
        .cornerRadius(8)
        .padding()
        
        Spacer()
    }
    
    @ViewBuilder
    var noProfile: some View {
        Spacer()
        HStack {
            Image("person-icon-denied")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 65, height: 65)
                .padding()
                .overlay(Circle()
                    .stroke(lineWidth: 3)
                    .opacity(0.4))
                .foregroundColor(Color(UIColor.systemBlue))
        }
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
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
