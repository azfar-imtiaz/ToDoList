//
//  ProfileViewViewModel.swift
//  ToDoList
//
//  Created by Azfar Imtiaz on 2023-06-15.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class ProfileViewViewModel: ObservableObject {
    @Published var user: User? = nil
    @Published var registeredDays: Int = -1
    
    init() {}
    
    func fetchUser() {
        guard let userID = Auth.auth().currentUser?.uid else {
            return
        }
        let db = Firestore.firestore()
        db.collection("users").document(userID).getDocument { [weak self] snapshot, error in
            guard let data = snapshot?.data(), error == nil else {
                return
            }
            
            DispatchQueue.main.async {
                self?.user = User(
                    id: data["id"] as? String ?? "",
                    name: data["name"] as? String ?? "",
                    emailAddress: data["emailAddress"] as? String ?? "",
                    joinDate: data["joinDate"] as? TimeInterval ?? 0)
                
                if let joinDate = self?.user?.joinDate {
                    let startDate = Date(timeIntervalSince1970: joinDate)
                    let endDate = Date()
                    self?.registeredDays = Calendar.current.dateComponents([.day], from: startDate, to: endDate).day!
                }
            }
        }
    }
    
    func logOut() {
        do {
            try Auth.auth().signOut()
        } catch {
            print(error)
        }
    }
}
