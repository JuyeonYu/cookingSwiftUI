//
//  Test2View.swift
//  SUTest
//
//  Created by  유 주연 on 8/9/24.
//

import SwiftUI

struct BindingView: View {
  @Binding var show: Bool
  @Binding var model: StructModel
  @State var originalModel: StructModel
  
  init(model: Binding<StructModel>, show: Binding<Bool>) {
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
  BindingView(model: .constant(.init(header: "t", body: "2", footers: ["123"], selectedFooters: [false])), show: .constant(true))
}



