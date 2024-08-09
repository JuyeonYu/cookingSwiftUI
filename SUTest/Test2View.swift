//
//  Test2View.swift
//  SUTest
//
//  Created by  유 주연 on 8/9/24.
//

import SwiftUI

struct Test2View: View {
  @Binding var model: Model
    var body: some View {
      Cell(model: $model)
    }
}

#Preview {
  Test2View(model: .constant(.init(header: "t", body: "2", footers: ["123"], selectedFooters: [false])))
}



