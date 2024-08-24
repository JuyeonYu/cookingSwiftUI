//
//  ChipInScrollView.swift
//  SUTest
//
//  Created by  유 주연 on 8/22/24.
//

import SwiftUI
import Flow

struct ChipInScrollView: View {
  @State var chipModel: [String] = [
    "test100", "test101", "test102", "test103", "test104", "test105", "test106", "test107", "test108", "test109", "test110",
    "test111", "test112", "test113", "test114", "test115", "test116", "test117", "test118", "test119", "test120",
    "test121", "test122", "test123", "test124", "test125", "test126", "test127", "test128", "test129", "test130"
  ]
  
  @State private var sample: [String] = [
      "123",
      "123456",
      "abcdefg",
      "가나다라마바사",
      "안녕하세요",
      "1",
      "11234",
      "123 234",
  ]
  
  
    var body: some View {
      ScrollView {
        Image(systemName: "circle")
          .resizable()
          .aspectRatio(contentMode: .fit)
          .frame(height: 100)
          .background(.gray)
        
//          ChipLayout(verticalSpacing: 16, horizontalSpacing: 16) {
//            ForEach(chipModel, id: \.self) { chip in
//              Text(chip)
//            }
//          }.background(.red)
        
        HFlow(itemSpacing: 10, rowSpacing: 20) {
          ForEach(chipModel, id: \.self) { chip in
            Text(chip)
              .padding(.horizontal, 12)
              .padding(.vertical, 5)
              .background(
                  Capsule().foregroundStyle(.blue)
              )
              .onTapGesture {
                chipModel.remove(at: 0)
              }
          }
        }.background(.red)
        
        
        Image(systemName: "circle")
          .resizable()
          .aspectRatio(contentMode: .fit)
          .frame(height: 100)
          .background(.gray)
        
//        ChipLayout(verticalSpacing: 16, horizontalSpacing: 16) {
//          ForEach(chipModel, id: \.self) { chip in
//            Text(chip)
//          }
//        }.background(.blue)
        
        Spacer()
          .background(.gray)
          
        
      }.background(.yellow)
        .padding()
        .onAppear(perform: {
//          DispatchQueue.main.asyncAfter(deadline: .now()) {
//            chipModel = [
//              "test100", "test101", "test102", "test103", "test104", "test105", "test106", "test107", "test108", "test109", "test110",
//              "test111", "test112", "test113", "test114", "test115", "test116", "test117", "test118", "test119", "test120",
//              "test121", "test122", "test123", "test124", "test125", "test126", "test127", "test128", "test129", "test130"
//            ]
//          }
        })
//      ScrollView {
//          ChipLayout(verticalSpacing: 8, horizontalSpacing: 8) {
//              ForEach(sample.indices, id: \.self) { index in
//                  let model = sample[index]
//                  Text(model)
//                      .padding(.horizontal, 12)
//                      .padding(.vertical, 5)
//                      .background(
//                          Capsule().foregroundStyle(.blue)
//                      )
//              }
//          }
//          .border(.black)
//        Text("123123")
//        Image(systemName: "circle")
//          .resizable()
//          .aspectRatio(contentMode: .fit)
//          .frame(height: 100)
//          .background(.gray)

      
    }
}

#Preview {
    ChipInScrollView()
}


//struct ChipLayout: Layout {
//    var verticalSpacing: CGFloat = 0
//    var horizontalSpacing: CGFloat = 0
//    
//    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
//        return CGSize(width: proposal.width ?? 0, height: proposal.height ?? 0)
//    }
//    
//    // proposal 제공 뷰크기
//    // bounds 위치
//    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
//        print("bound: ", bounds)
//        print("proposal: ", proposal)
//        
//        var sumX: CGFloat = bounds.minX
//        var sumY: CGFloat = bounds.minY
//       
//        for index in subviews.indices {
//            let view = subviews[index]
//            let viewSize = view.sizeThatFits(.unspecified)
//            guard let proposalWidth = proposal.width else { continue }
//            
//            // 가로 끝인경우 아래로 이동
//            if (sumX + viewSize.width > proposalWidth) {
//                sumX = bounds.minX
//                sumY += viewSize.height
//                sumY += verticalSpacing
//            }
//            
//            let point = CGPoint(x: sumX, y: sumY)
//            // anchor: point의 기준 적용지점
//            // proposal: unspecified, infinity -> 넘어감, zero -> 사라짐, size -> 제안한크기 만큼 지정됨
//            // size지정해줘야 텍스트긴경우 짤림
//            view.place(at: point, anchor: .topLeading, proposal: proposal)
//            sumX += viewSize.width
//            sumX += horizontalSpacing
//        }
//    }
//    
//}

struct ChipLayout: Layout {
    var verticalSpacing: CGFloat = 0
    var horizontalSpacing: CGFloat = 0
    
    // scrollView에서 height = nil
    // ✅ 변경된 부분 cache
    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout Cache) -> CGSize {
        print("--sizeThatFits--", cache)
        // ✅ 추가된 부분
        return CGSize(width: proposal.width ?? 0, height: cache.height)
    }
    
    // proposal 제공 뷰크기
    // bounds 위치
    // ✅ 변경된 부분 cache
    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout Cache) {
        print("--placeSubviews--")
        print("bound: ", bounds)
        print("proposal: ", proposal)
        
        var sumX: CGFloat = bounds.minX
        var sumY: CGFloat = bounds.minY
       
        for index in subviews.indices {
            let view = subviews[index]
            let viewSize = view.sizeThatFits(.unspecified)
            guard let proposalWidth = proposal.width else { continue }
            
            // 가로 끝인경우 아래로 이동
            if (sumX + viewSize.width > proposalWidth) {
                sumX = bounds.minX
                sumY += viewSize.height
                sumY += verticalSpacing
            }
            
            let point = CGPoint(x: sumX, y: sumY)
            // anchor: point의 기준 적용지점
            // proposal: unspecified, infinity -> 넘어감, zero -> 사라짐, size -> 제안한크기 만큼 지정됨
            view.place(at: point, anchor: .topLeading, proposal: proposal)
            sumX += viewSize.width
            sumX += horizontalSpacing
            

        }
        // ✅ 추가된 부분
        if let firstViewSize = subviews.first?.sizeThatFits(.unspecified) {
            // sumY는 topLeading 기준의 좌표이므로 height를 구하려면
            // chip뷰의 height를 더해야 전체 높이값이 나옵니다.
            cache.height = sumY + firstViewSize.height
        }
    }
    
    // ✅ 추가된 부분
    
    struct Cache {
        var height: CGFloat
    }
    
    func makeCache(subviews: Subviews) -> Cache {
        print("make cache")
        return Cache(height: 0)
    }
    
    func updateCache(_ cache: inout Cache, subviews: Subviews) {
        print("update cache", cache)
    }
}
