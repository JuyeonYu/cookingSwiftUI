//
//  ClassModel.swift
//  SUTest
//
//  Created by  유 주연 on 8/10/24.
//

import Foundation

class ClassModel: Identifiable, Hashable, ObservableObject {
  static func == (lhs: ClassModel, rhs: ClassModel) -> Bool {
    lhs.id == rhs.id
  }
  func hash(into hasher: inout Hasher) {
    hasher.combine(id)
  }
  
    var id: UUID = UUID()
    @Published var header: String
  @Published var body: String
  @Published var footers: [String]
  @Published var selectedFooters: [Bool]
  
  init(header: String, body: String, footers: [String], selectedFooters: [Bool]) {
    self.header = header
    self.body = body
    self.footers = footers
    self.selectedFooters = selectedFooters
  }
  
  static func generateMocks() -> [ClassModel] {
      var newMocks: [ClassModel] = []
      for i in 0 ..< 20 {
        var mock: ClassModel = .init(header: "header\(i)", body: "body\(i)", footers: [], selectedFooters: [])
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
