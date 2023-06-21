//
//  TLButton.swift
//  ToDoList
//
//  Created by Azfar Imtiaz on 2023-06-19.
//

import SwiftUI

struct TLButton: View {
    let title: String
    let backgroundColor: Color
    let action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            Text(title)
                .foregroundColor(Color.white)
                .bold()
                .frame(maxWidth: .infinity)
                .padding(.vertical, 10)
                .background {
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundColor(backgroundColor)
                        .padding(.horizontal)

                }
        }
    }
}

struct TLButton_Previews: PreviewProvider {
    static var previews: some View {
        TLButton(title: "Value", backgroundColor: Color.pink) {
            // action
        }
        .padding()
    }
}
