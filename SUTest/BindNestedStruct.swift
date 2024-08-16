//
//  BindNestedStruct.swift
//  SUTest
//
//  Created by  유 주연 on 8/16/24.
//

import SwiftUI

struct BindNestedStruct: View {
  @Binding var user: NestedStructUser
    var body: some View {
      VStack {
        TextField("1", text: $user.name)
        TextField("2", text: $user.address.state)
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
        TextField("3", text: $user.address.detail)
        
        HStack {
          Text("\(user.address.system.code)")
          Text(user.address.system.jibun)
          Spacer()
          Button("+") {
            user.address.system.code += 1
          }
          Button("-") {
            user.address.system.code -= 1
          }
          
        }
      }.padding()
      
    }
}

#Preview {
  BindNestedStruct(user: .constant(.init(name: "", age: 30, address: .init(state: "", detail: "", system: .init(code: 200, jibun: "")))))
}
