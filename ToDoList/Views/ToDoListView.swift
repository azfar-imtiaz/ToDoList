//
//  ToDoListView.swift
//  ToDoList
//
//  Created by Azfar Imtiaz on 2023-06-15.
//

import SwiftUI
import FirebaseFirestoreSwift

struct ToDoListView: View {
    @StateObject var viewModel: ToDoListViewViewModel
    @FirestoreQuery var items: [ToDoListItem]
    
//    private let userID: String
    init(userID: String) {
        self.userID = userID
        self._items = FirestoreQuery(
            collectionPath: "users/\(userID)/ToDos")
        // we initialize this like so here because we want it to store user ID
        self._viewModel = StateObject(
            wrappedValue: ToDoListViewViewModel(userID: userID))
    }
    
    var body: some View {
        let sortedItemsComplete = getSortedItems(completed: false, items: items)
        let sortedItemsIncomplete = getSortedItems(completed: true, items: items)
        NavigationView {
            VStack {
                Spacer()
                Text("Incomplete Tasks")
                    .font(.title2)
                    .foregroundColor(.pink)
                if sortedItemsComplete.count > 0 {
                    displayItems(sortedItems: sortedItemsComplete)
                    .listStyle(.inset)
                    .overlay(RoundedRectangle(cornerRadius: 16)
                        .strokeBorder(.gray, lineWidth: 3)
                        .opacity(0.2))
                    .padding()
                    .frame(height: UIScreen.main.bounds.height * 0.4)
                } else {
                    Text("You are done for the day - grab a beer and relax you big MO!")
                        .padding()
                        .multilineTextAlignment(.center)
                        .background(.thickMaterial)
                        .cornerRadius(10)
                }
                
                Text("Completed Tasks")
                    .font(.title2)
                    .foregroundColor(.green)
                displayItems(sortedItems: sortedItemsIncomplete)
                .listStyle(.plain)
                .overlay(RoundedRectangle(cornerRadius: 16)
                    .strokeBorder(.gray, lineWidth: 3)
                    .opacity(0.2))
                .padding()
            }
            .navigationTitle("To Do List")
            .toolbar {
                Button {
                    viewModel.showingNewItemView = true
                } label: {
                    Image(systemName: "plus")
                }
            }
            .sheet(isPresented: $viewModel.showingNewItemView) {
                NewItemView(newItemPresented: $viewModel.showingNewItemView)
            }
        }
    }
    
    @ViewBuilder
    func displayItems(sortedItems: [ToDoListItem]) -> some View {
        List(sortedItems) { item in
            ToDoListItemView(item: item)
                .swipeActions {
                    Button("Delete") {
                        viewModel.delete(itemID: item.id)
                    }
                    .tint(Color.red)
                }
                .padding(.vertical)
        }
    }
    
    func getSortedItems(completed: Bool, items: [ToDoListItem]) -> [ToDoListItem] {
        return items.filter { $0.isDone == completed }.sorted {
            $0.dueDate < $1.dueDate
        }
    }
}

struct ToDoListView_Previews: PreviewProvider {
    static var previews: some View {
        ToDoListView(userID: "5lbdg6FQaMhItGAq1AKwbCMCkfq1")
    }
}
