//
//  ToDoListItemView.swift
//  ToDoList
//
//  Created by Azfar Imtiaz on 2023-06-15.
//

import SwiftUI

struct ToDoListItemView: View {
    @StateObject var viewModel = ToDoListItemViewViewModel()
    let item: ToDoListItem
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(item.title)
                    .strikethrough(item.isDone ? true : false)
                    .font(.body)
                    .padding(.bottom, 5)
                    .foregroundColor(item.isDone == true ? Color.gray : Color.black)
                
                Text("\(Date(timeIntervalSince1970: item.dueDate).formatted(date: .abbreviated, time: .shortened))")
                    .font(.footnote)
                    .foregroundColor(item.isDone == true ? Color.gray : item.dueDate.isLess(than: Date().timeIntervalSince1970) ? Color.red : Color(.secondaryLabel))
            }
            
            Spacer()
            
            Button {
                viewModel.toggleIsDone(item: item)
            } label: {
                Image(systemName: item.isDone ? "checkmark.circle.fill" : "circle")
                    .foregroundColor(.blue)
            }
        }
    }
}

struct ToDoListItemView_Previews: PreviewProvider {
    static var previews: some View {
        ToDoListItemView(item: ToDoListItem(
            id: "some_random_id",
            title: "Buy bread",
            dueDate: Date().timeIntervalSince1970,
            createdDate: Date().timeIntervalSince1970,
            completedDate: Date().addingTimeInterval(-86400).timeIntervalSince1970,
            isDone: false)
        )
    }
}
