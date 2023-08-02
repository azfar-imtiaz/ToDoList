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
    
    private let userID: String
    init(userID: String) {
        self.userID = userID
        self._items = FirestoreQuery(
            collectionPath: "users/\(userID)/ToDos")
        // we initialize this like so here because we want it to store user ID
        self._viewModel = StateObject(
            wrappedValue: ToDoListViewViewModel(userID: userID))
    }
    
    var body: some View {
        let sortedItemsComplete = getSortedItems(completed: true, items: items)
        let sortedItemsIncomplete = getSortedItems(completed: false, items: items)
        NavigationView {
            VStack(alignment: .leading) {
                Spacer()
                Text("Incomplete Tasks")
                    .font(.bold(.title3)())
                    .foregroundColor(.pink)
                    .padding(.horizontal)
                if sortedItemsIncomplete.count > 0 {
                    displayItems(sortedItems: sortedItemsIncomplete, tasksComplete: false)
                        .frame(maxHeight: UIScreen.main.bounds.height * 0.4)
                        .fixedSize(horizontal: false, vertical: true)
                } else {
                    Text("You are done for the day - grab a RoohAfza and relax!")
                        .padding()
                        .multilineTextAlignment(.center)
                        .background(.thickMaterial)
                        .cornerRadius(10)
                }
                
                Text("Completed Tasks")
                    .font(.bold(.title3)())
                    .foregroundColor(.green)
                    .padding(.horizontal)
                displayItems(sortedItems: sortedItemsComplete, tasksComplete: true)
                    .frame(maxHeight: .infinity)
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
    func displayItems(sortedItems: [ToDoListItem], tasksComplete: Bool) -> some View {
        /*List(sortedItems) { item in
            ToDoListItemView(item: item)
                .swipeActions {
                    Button("Delete") {
                        viewModel.delete(itemID: item.id)
                    }
                    .tint(Color.red)
                }
                .padding(.vertical)
        }*/
        ScrollView {
            Spacer()
            ForEach(sortedItems) { item in
                VStack {
                    ToDoListItemView(item: item)
                        .swipeActions {
                            Button("Delete") {
                                viewModel.delete(itemID: item.id)
                            }
                            .tint(.red)
                        }
                        .padding(tasksComplete ? .horizontal : .all)
                }
                Divider()
                    .padding(.horizontal)
            }
        }
        .overlay(RoundedRectangle(cornerRadius: 16)
            .strokeBorder(.gray, lineWidth: 3)
            .opacity(0.2))
        .padding()
        
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
