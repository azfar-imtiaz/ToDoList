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
            VStack() {
                Spacer()
                /* if self.viewModel.completionPercentage < 0.0 {
                    Text("Calculating percentage... Check again in a while.")
                        .padding()
                }*/
            
                VStack(alignment: .leading) {
                    Section("Task Stats") {
                        tasksStatsView(taskStats: self.viewModel.taskStatistics)
                    }
                }
                .font(.title2
                    .weight(.semibold))
                .padding(.horizontal)
                
                Spacer()
                
                VStack(alignment: .leading) {
                    Section("Completion Percentage") {
                        completionPercentageView(
                            subheaderText: "OVERALL",
                            percentage: self.viewModel.completionPercentage)
                        
                        completionPercentageView(
                            subheaderText: "ON TIME",
                            percentage: self.viewModel.completionOnTimePercentage)
                    }
                    .font(.title2
                        .weight(.semibold))
                    .padding(.horizontal)
                }
                Spacer()
            }
            .navigationTitle("Task Completion")
        }
        .onAppear() {
            viewModel.calculateCompletionPercentage()
        }
    }
    
    @ViewBuilder
    func tasksStatsView(taskStats: TaskStats) -> some View {
        VStack {
            HStack {
                Text("Total Tasks Added")
                Spacer()
                Text(String(taskStats.totalTasks))
            }
            .padding()
            Divider().padding(.horizontal)
            HStack {
                Text("Tasks Completed")
                Spacer()
                Text(String(taskStats.completedTasks))
            }
            .padding()
            Divider().padding(.horizontal)
            HStack {
                Text("Tasks Completed (on time)")
                Spacer()
                Text(String(taskStats.completedOnTimeTasks))
            }
            .padding()
        }
        .background(Color(UIColor.systemGroupedBackground))
        .cornerRadius(8)
        .font(.body)
    }
    
    @ViewBuilder
    func completionPercentageView(subheaderText: String, percentage: Double) -> some View {
        VStack {
            Text(subheaderText)
                .font(.body)
                .padding(.top)
            Text(String(format: "%d %%", Int(percentage.rounded())))
                .font(.title2)
                .padding()
                .frame(maxWidth: UIScreen.main.bounds.width, alignment: .center)
                .foregroundColor(percentage >= 50.0 ? .green : .pink)
        }
        .background(Color(UIColor.systemGroupedBackground))
        .cornerRadius(8)
        .padding(.bottom)
    }
}

struct TaskCompletionView_Previews: PreviewProvider {
    static var previews: some View {
        TaskCompletionView(userID: "")
    }
}
