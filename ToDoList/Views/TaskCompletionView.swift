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
            
                completionPercentageView(headerText: "Tasks completed overall", percentage: self.viewModel.completionPercentage)
                    .background(Color(UIColor.systemGroupedBackground))
                    .cornerRadius(8)
                    .padding()

                completionPercentageView(headerText: "Tasks completed on time", percentage: self.viewModel.completionOnTimePercentage)
                    .background(Color(UIColor.systemGroupedBackground))
                    .cornerRadius(8)
                    .padding()
                Spacer()
            }
            .navigationTitle("Task Completion")
        }
        .onAppear() {
            viewModel.calculateCompletionPercentage()
        }
    }
    
    @ViewBuilder
    func completionPercentageView(headerText: String, percentage: Double) -> some View {
        VStack() {
            Text(headerText)
                .padding()
                .font(.title)
            Text(String(format: "%.1f%", percentage))
                .font(.title)
                .padding()
                .frame(maxWidth: UIScreen.main.bounds.width, alignment: .center)
                .foregroundColor(percentage >= 50.0 ? .green : .pink)
        }
    }
}

struct TaskCompletionView_Previews: PreviewProvider {
    static var previews: some View {
        TaskCompletionView(userID: "17HZ03u2R3UFV75wVPjK5oh0PeF3")
    }
}
