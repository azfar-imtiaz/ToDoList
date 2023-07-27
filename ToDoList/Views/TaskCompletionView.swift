//
//  TaskCompletionView.swift
//  ToDoList
//
//  Created by Azfar Imtiaz on 2023-07-27.
//

import SwiftUI

struct TaskCompletionView: View {
    @StateObject var viewModel: TaskCompletionViewViewModel
    
    private let userID: String
    @State var completionPercentage: Double = 0
    
    init(userID: String) {
        self.userID = userID
        self._viewModel = StateObject(wrappedValue: TaskCompletionViewViewModel(userID: userID))
    }
    
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                if self.viewModel.completionPercentage < 0.0 {
                    Text("Calculating percentage... Check again in a while.")
                        .padding()
                } else {
                    Text("Your task completion percentage is:")
                        .padding()
                    Text(String(format: "%.1f%", self.viewModel.completionPercentage))
                        .padding()
                        .font(.title)
                        .foregroundColor(self.viewModel.completionPercentage >= 50.0 ? .green : .gray)
                }
                Spacer()
            }
            .navigationTitle("Task Completion")
        }
        .onAppear() {
            viewModel.calculateCompletionPercentage()
        }
    }
}

struct TaskCompletionView_Previews: PreviewProvider {
    static var previews: some View {
        TaskCompletionView(userID: "17HZ03u2R3UFV75wVPjK5oh0PeF3")
    }
}
