//
//  ContentView.swift
//  SUTest
//
//  Created by  유 주연 on 8/8/24.
//

import SwiftUI
import SwiftUICustomTagListView

struct StateView: View {
  @State var viewDidLoad = false
  @State private var mocks: [StructModel]
  @State private var isLoading = false
  @State private var showDetailView = false
  @State private var selectedRow: Int = 0
  
  init() {
    self._mocks = .init(initialValue: StructModel.generateMocks())
  }
  
  var body: some View {
    ScrollView {
      LazyVStack(alignment: .leading) {
        ForEach(0..<mocks.count, id: \.self) { row in
          Cell(model: $mocks[row])
            .onTapGesture {
              selectedRow = row
              showDetailView.toggle()
            }
          
        }
        
      }.padding()
    }.sheet(isPresented: $showDetailView, content: {
      BindingView(model: $mocks[selectedRow], show: $showDetailView)
    })
    }
  
}





#Preview {
  StateView()
}
