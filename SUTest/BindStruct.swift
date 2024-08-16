//
//  BindStruct.swift
//  SUTest
//
//  Created by  유 주연 on 8/16/24.
//

import SwiftUI

struct BindStruct: View {
  @Binding var user: User
    var body: some View {
      VStack {
        
        TextField("name", text: $user.name)
        HStack {
          Text("\(user.age)")
          Spacer()
          Button("+") {
            user.age += 1
          }
          Button("-") {
            user.age -= 1
          }
        }
        
      }.padding()
    }
}

#Preview {
  BindStruct(user: .constant(.init(name: "w", age: 1)))
}
