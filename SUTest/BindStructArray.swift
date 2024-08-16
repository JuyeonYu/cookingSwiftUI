//
//  BindStructArray.swift
//  SUTest
//
//  Created by  유 주연 on 8/16/24.
//

import SwiftUI

struct BindStructArray: View {
  @Binding var users: [User]
    var body: some View {
      VStack {
        let test = $users
        
        ForEach($users) { $user in
          TextField("1", text: $user.name)
          Text(user.name)
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
          
          Divider()
        }
      }.padding()
    }
}

#Preview {
  BindStructArray(users: .constant([]))
}
