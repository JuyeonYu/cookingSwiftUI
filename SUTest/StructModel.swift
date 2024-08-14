//
//  StructModel.swift
//  SUTest
//
//  Created by  유 주연 on 8/10/24.
//

import Foundation

struct StructModel: Identifiable, Hashable {
    var id: UUID = UUID()
    var header, body: String
    var footers: [String]
    var selectedFooters: [Bool]
  
  static func generateMocks() -> [StructModel] {
      var newMocks: [StructModel] = []
      for i in 0 ..< 20 {
        var mock: StructModel = .init(header: "header\(i)", body: "body\(i)", footers: [], selectedFooters: [])
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

struct StructUser: Identifiable, Hashable {
  static func == (lhs: StructUser, rhs: StructUser) -> Bool {
    lhs.id == rhs.id
  }
  func hash(into hasher: inout Hasher) {
    hasher.combine(id)
    hasher.combine(name)
  }
  

  
  var id: UUID = UUID()
  var name: String
  var address: StructAddress
  var classAddress: ClassAddress
}

struct StructAddress {
  var state: String
  var detail: String
}

class ClassAddress: ObservableObject {
  @Published var state: String
  @Published var detail: String
  
  init(state: String, detail: String) {
    self.state = state
    self.detail = detail
  }
}
