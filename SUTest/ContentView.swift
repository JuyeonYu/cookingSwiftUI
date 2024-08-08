//
//  ContentView.swift
//  SUTest
//
//  Created by  유 주연 on 8/8/24.
//

import SwiftUI
import SwiftUICustomTagListView

struct ContentView: View {
  @State private var mocks: [Model] = [.init(header: "t1", body: "b1", footers: ["123"])]
  @State private var isLoading = false
  
  var body: some View {
      ScrollView {
        LazyVStack(alignment: .leading) {
          ForEach(mocks) { mock in
            Group {
              Text(mocks[0].header)
              Text(mocks[0].body)
              
              SwiftUICustomTagListView(mock.footers.map { footer in
                SwiftUICustomTagView {
                  Text(footer)
                    .padding()
                    .background(Color.gray)
                    .clipShape(.capsule)
                }
                
              }, horizontalSpace: 8, verticalSpace: 8)
            }.onAppear(perform: {
              guard mock.id == mocks.last?.id else { return }
              var newMocks: [Model] = []
              for i in 0 ..< 20 {
                var mock: Model = .init(header: "header\(i)", body: "body\(i)", footers: [])
                var footers: [String] = []
                for i in 1 ... Int.random(in: 3 ... 20) {
                  let random = Int.random(in: 10...1000)
                  footers.append("\(random)")
                }
                mock.footers = footers
                newMocks.append(mock)
              }
              mocks.append(contentsOf: newMocks)
            })
          }
        }.padding()
      .onAppear {
        generateMocks()
      }
    }
  }

    
    private func generateMocks() {
        var newMocks: [Model] = []
        for i in 0 ..< 20 {
          var mock: Model = .init(header: "header\(i)", body: "body\(i)", footers: [])
          var footers: [String] = []
          for i in 1 ... Int.random(in: 3 ... 20) {
            let random = Int.random(in: 10...1000)
            footers.append("\(random)")
          }
          mock.footers = footers
          newMocks.append(mock)
        }
        mocks = newMocks
    }
}

struct Model: Identifiable, Hashable {
    var id: UUID = UUID()
    var header, body: String
    var footers: [String]
}

struct ChipLayout<Content: View>: View {
    let items: [String]
    let content: (String) -> Content
    
    var body: some View {
        FlowLayout(items: items, content: content)
            .padding(.vertical, 4)
    }
}

struct FlowLayout<Content: View>: View {
    let items: [String]
    let content: (String) -> Content
    
    var body: some View {
        GeometryReader { geometry in
            let width = geometry.size.width
            var xOffset: CGFloat = 0
            var yOffset: CGFloat = 0
            let spacing: CGFloat = 8
            
            VStack(alignment: .leading, spacing: spacing) {
                ForEach(items, id: \.self) { item in
                    content(item)
                        .background(GeometryReader { itemGeometry in
                            Color.clear
                                .onAppear {
                                    let itemWidth = itemGeometry.size.width
                                    if xOffset + itemWidth > width {
                                        xOffset = 0
                                        yOffset += itemGeometry.size.height + spacing
                                    }
                                    xOffset += itemWidth + spacing
                                }
                        })
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}

#Preview {
    ContentView()
}
