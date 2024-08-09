//
//  Test2View.swift
//  SUTest
//
//  Created by  유 주연 on 8/9/24.
//

import SwiftUI

struct Test2View: View {
  @Binding var show: Bool
  @Binding var model: Model
  @State var originalModel: Model
  
  init(model: Binding<Model>, show: Binding<Bool>) {
    self._show = show
    self._model = model
    self._originalModel = .init(initialValue: model.wrappedValue)
  }
    var body: some View {
      VStack {
        
        Cell(model: $originalModel)
        HStack {
          Button("cancel") {
            show.toggle()
          }
          Button("ok") {
            show.toggle()
            model = originalModel
          }
        }
      }.onAppear(perform: {
        
      })
    }
}

#Preview {
  Test2View(model: .constant(.init(header: "t", body: "2", footers: ["123"], selectedFooters: [false])), show: .constant(true))
}



