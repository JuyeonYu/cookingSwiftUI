//
//  EditNestedStructView.swift
//  SUTest
//
//  Created by  유 주연 on 8/10/24.
//

import SwiftUI

struct EditNestedStructView: View {
  @Binding var show: Bool
  @Binding var user: StructUser
  @State var name: String
  @ObservedObject var classAddress: ClassAddress
  
  init(show: Binding<Bool>, user: Binding<StructUser>, classAddress: ClassAddress) {
    self._show = show
    self._user = user
    self._name = .init(initialValue: user.name.wrappedValue)
    self._classAddress = ObservedObject(wrappedValue: classAddress)
  }
  
    var body: some View {
      VStack {
        Text("string")
        TextField("name", text: $name)
        
        Divider()
        
        Text("struct")
        TextField("name", text: $name)
        
        HStack {
          Button(action: {
            show = false
          }, label: {
            Text("cancel")
          })
          Spacer()
          
          Button(action: {
            user.name = name
            show = false

          }, label: {
            Text("확인")
          })
        }
        Divider()
        Text("address")
        TextField("state", text: $user.address.state)
        TextField("detail", text: $user.address.detail)
        
        Divider()
        Text("classaddress")
        TextField("state", text: $classAddress.state)
        TextField("detail", text: $classAddress.detail)
      }.padding()
      
    }
}

#Preview {
  EditNestedStructView(show: .constant(false), user: .constant(.init(name: "", address: .init(state: "", detail: ""), classAddress: .init(state: "", detail: ""))), classAddress: .init(state: "", detail: ""))
}
