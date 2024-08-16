//
//  StateNestedStruct.swift
//  SUTest
//
//  Created by  유 주연 on 8/16/24.
//

import SwiftUI

struct StateNestedStruct: View {
  @State var user: NestedStructUser = .init(name: "주연", age: 30, address: .init(state: "분당", detail: "무지개", system: .init(code: 200, jibun: "번지")))
  @State var show: Bool = false
    var body: some View {
      VStack {
        Text(user.name)
        Text("\(user.age)")
        Text(user.address.state)
        Text(user.address.detail)
        
        HStack {
          Text("\(user.address.system.code)")
          Text(user.address.system.jibun)
        }
        Button("go") {
          show = true
        }

      }.sheet(isPresented: $show, content: {
        BindNestedStruct(user: $user)
      })
    }
}

#Preview {
    StateNestedStruct()
}

struct NestedStructUser {
  var name: String
  var age: Int
  var address: Address
  
  
  struct Address {
    var state: String
    var detail: String
    var system: AddressSystem
    
    
    struct AddressSystem {
      var code: Int
      var jibun: String
    }
  }
}
