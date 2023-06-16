//
//  HeaderView.swift
//  ToDoList
//
//  Created by Azfar Imtiaz on 2023-06-15.
//

import SwiftUI

struct HeaderView: View {
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 0)
                .foregroundColor(Color.pink)
                .rotationEffect(Angle(degrees: 15))
            
            VStack {
                Text("To Do List")
                    .foregroundColor(.white)
                    .bold()
                    .font(.system(size: 50))
                
                Text("Get things done!")
                    .foregroundColor(.white)
                    .font(.system(size: 30))
            }
            .padding(.top, 30 )
        }
        .frame(width: UIScreen.main.bounds.width * 3,
               height: 300)
        .offset(y: -100)
    }
}

struct HeaderView_Previews: PreviewProvider {
    static var previews: some View {
        HeaderView()
    }
}
