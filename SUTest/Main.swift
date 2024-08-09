//
//  Main.swift
//  SUTest
//
//  Created by  유 주연 on 8/10/24.
//

import SwiftUI

struct Main: View {
  
  @State var  items: [String] = [
    "State & Binding",
    "StateObject & OnservedObject"
  ]
  
  @State var show1: Bool = false
  @State var show2: Bool = false
  
    var body: some View {
      List {
        ForEach(items, id: \.self) { item in
          Button(item) {
            if item == items[0] {
              show1 = true
            } else if item == items[1] {
              show2 = true
            }
          }
        }
        .sheet(isPresented: $show1, content: {
          StateView()
        })
        .sheet(isPresented: $show2, content: {
          StateObjectView()
        })
      }
    }
}

#Preview {
    Main()
}
