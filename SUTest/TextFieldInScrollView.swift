//
//  TextFieldInScrollView.swift
//  SUTest
//
//  Created by  유 주연 on 8/25/24.
//

import SwiftUI

struct TextFieldInScrollView: View {
  @State var text: String = ""
    var body: some View {
      ScrollViewReader { proxy in
        ScrollView {
          Text("Hello, World!")
          Image(systemName: "circle")
            .frame(height: 500)
          TextField("", text: $text, prompt: Text("input"), axis: .vertical)
            .background(Color.red)
            .id(1)
            .onChange(of: text) { oldValue, newValue in
              proxy.scrollTo(1, anchor: .bottom)
            }
        }
      }
        
    }
}

#Preview {
    TextFieldInScrollView()
}
