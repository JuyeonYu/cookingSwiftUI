//
//  StateStruct.swift
//  SUTest
//
//  Created by  유 주연 on 8/16/24.
//

import SwiftUI

struct StateStruct: View {
  @State private var user: User = .init(name: "주연", age: 30)
  @State private var show: Bool = false
    var body: some View {
      VStack {
        Text(user.name)
        Text("\(user.age)")
        Button("next") {
          show = true
        }
      }.padding()
        .sheet(isPresented: $show, content: {
          BindStruct(user: $user)
        })
    }
}

#Preview {
    StateStruct()
}


struct User: Identifiable {
  var id: UUID = UUID()
  
  var name: String
  var age: Int
}
