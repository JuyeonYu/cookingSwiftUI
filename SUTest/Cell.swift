//
//  Cell.swift
//  SUTest
//
//  Created by  유 주연 on 8/10/24.
//

import Foundation
import SwiftUI
import SwiftUICustomTagListView

struct Cell: View {
  @Binding var model: StructModel
  
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


struct ClassCell: View {
  @ObservedObject var model: ClassModel
  
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
