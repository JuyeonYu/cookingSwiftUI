//
//  ContentView.swift
//  SUTest
//
//  Created by  유 주연 on 8/8/24.
//

import SwiftUI
import SwiftUICustomTagListView

struct ContentView: View {
  @State var viewDidLoad = false
  @State private var mocks: [Model] = [.init(header: "t1", body: "b1", footers: ["123"], selectedFooters: [false])]
  @State private var isLoading = false
  
  var body: some View {
    NavigationView(content: {
      
      
      ScrollView {
        LazyVStack(alignment: .leading) {
          ForEach(0..<mocks.count, id: \.self) { row in
          NavigationLink {
            Test2View(model: $mocks[row])
          } label: {
                Cell(model: $mocks[row])
            }
          }
          
        }.padding()
          .onAppear {
            if !viewDidLoad {
              self.mocks = Model.generateMocks()
            }
            viewDidLoad = true
            
          }
      }
    })
  }
  
  
    private func generateMocks() {
        var newMocks: [Model] = []
        for i in 0 ..< 20 {
          var mock: Model = .init(header: "header\(i)", body: "body\(i)", footers: [], selectedFooters: [])
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

struct Cell: View {
  @Binding var model: Model
  
  var body: some View {
    Text(model.header)
    Text(model.body)
    Button(model.selectedFooters.reduce(true, { $0 && $1 }) ? "모두 해제" : "모두 선택") {
      let selectedAll = model.selectedFooters.filter { $0 }.count == model.footers.count
      model.selectedFooters = model.selectedFooters.map { _ in selectedAll ? false : true }
    }
    
    SwiftUICustomTagListView(model.footers.map { footer in
      var row = 0
      for index in 0 ..< model.footers.count {
        if model.footers[index] == footer {
          row = index
          break
        }
      }

      return SwiftUICustomTagView {
        Text(footer)
          .padding()
          .background(model.selectedFooters[row] ? Color.gray : .red)
          .clipShape(.capsule)
          .onTapGesture {
            for index in 0 ..< model.footers.count {
              if model.footers[index] == footer {
                model.footers[index] = "\(Int(model.footers[index])! + 1)"
                model.selectedFooters[row] = !model.selectedFooters[row]
              }
            }
          }
        
        
      }
      
    }, horizontalSpace: 8, verticalSpace: 8)
    if model.selectedFooters.filter({ $0 }).isEmpty {
      EmptyView()
    } else {
      Text("선택됨(\(model.selectedFooters.filter { $0 }.count))")
    }
  }
}

struct Model: Identifiable, Hashable {
    var id: UUID = UUID()
    var header, body: String
    var footers: [String]
    var selectedFooters: [Bool]
  
  static func generateMocks() -> [Model] {
      var newMocks: [Model] = []
      for i in 0 ..< 20 {
        var mock: Model = .init(header: "header\(i)", body: "body\(i)", footers: [], selectedFooters: [])
        var footers: [String] = []
        for i in 1 ... Int.random(in: 3 ... 20) {
          let random = Int.random(in: 10...1000)
          footers.append("\(random)")
        }
        mock.footers = footers
        mock.selectedFooters = Array.init(repeating: false, count: footers.count)
        newMocks.append(mock)
      }
      return newMocks
  }
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
