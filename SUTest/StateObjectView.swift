//
//  StateObjectView.swift
//  SUTest
//
//  Created by  유 주연 on 8/10/24.
//

import SwiftUI

struct StateObjectView: View {
  @StateObject var viewModel: StateObjectViewViewModel = StateObjectViewViewModel()
    var body: some View {
      List(viewModel.models, id: \.self) { mock in
        ClassCell(model: mock)
      }
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
  StateObjectView(viewModel: StateObjectViewViewModel())
}

class StateObjectViewViewModel: ObservableObject {
  init() {
    let randomFooterCount = Int.random(in: 0...10)
    
    _models = .init(
      initialValue: ClassModel.generateMocks()
    )
  }
  @Published var models: [ClassModel]
}
