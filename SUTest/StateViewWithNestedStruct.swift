//
//  StateViewWithNestedStruct.swift
//  SUTest
//
//  Created by  유 주연 on 8/10/24.
//

import SwiftUI

struct StateViewWithNestedStruct: View {
  @State var user: StructUser = .init(name: "주연", address: .init(state: "경기", detail: "무지개"), classAddress: .init(state: "고양", detail: "두산"))
  @StateObject var classAddress: ClassAddress = .init(state: "고양", detail: "두산")
  @State var name: String = "주연"
  @State var showEdit: Bool = false
    var body: some View {
      
      VStack {
        Text("String")
        Text(name)
        Divider()
        Text("userName")
        Text(user.name)
        Divider()
        
        Text("address")
        Text(user.address.state)
        Text(user.address.detail)
        
        Divider()
        
        Text("classaddress")
        Text(classAddress.state)
        Text(classAddress.detail)
        
        Button("edit") {
          showEdit = true
        }
      }.sheet(isPresented: $showEdit, content: {
        EditNestedStructView(show: $showEdit, user: $user, classAddress: classAddress)
      })
    }
}

#Preview {
    StateViewWithNestedStruct()
}
