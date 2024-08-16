//
//  StateStructArray.swift
//  SUTest
//
//  Created by  유 주연 on 8/16/24.
//

import SwiftUI

struct StateStructArray: View {
  @State var go: Bool = false
  @State var users: [User]
    var body: some View {
      VStack {
        ForEach(users) { user in
          Text(user.name)
          Text("\(user.age)")
          Divider()
        }
        Button("go") {
          go = true
        }
      }.sheet(isPresented: $go, content: {
        BindStructArray(users: $users)
      })
    }
}

#Preview {
  StateStructArray(users: [
    .init(name: "주연", age: 36),
    .init(name: "지영", age: 39),
    .init(name: "채호", age: 3),
    .init(name: "채아", age: 1)
  ])
}
