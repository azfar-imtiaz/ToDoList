//
//  ContentView.swift
//  ToDoList
//
//  Created by Azfar Imtiaz on 2023-06-15.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        NavigationView {
            LoginView()
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
