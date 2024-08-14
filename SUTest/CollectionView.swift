//
//  CollectionView.swift
//  SUTest
//
//  Created by  유 주연 on 8/14/24.
//

import SwiftUI

struct CollectionView: View {
  let mock = [
    URL(string: "https://t3.ftcdn.net/jpg/01/42/62/84/360_F_142628436_BdXXMV34Xf665lwSRmBbAVICjFXh7vG9.jpg")!,
    URL(string: "https://cdn.pixabay.com/photo/2014/06/03/19/38/test-361512_640.jpg")!,
    URL(string: "https://www.researchgate.net/publication/224624453/figure/fig1/AS:393833717223438@1470908683517/Original-colour-bar-static-test-image-used-in-analogue-television-II-METHODOLOGY.png")!,
    URL(string: "https://static6.depositphotos.com/1014550/624/i/450/depositphotos_6240474-stock-photo-test-word-on-keyboard.jpg")!,
    URL(string: "https://colortest.page/wp-content/uploads/2023/05/color-image-print-test-page-pdf.jpg")!,
    URL(string: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSqQXCfw2Ulfrfe1xG2NGkSe7FOnT0h9AEjcQ&s")!,
    URL(string: "https://www.shutterstock.com/image-photo/word-test-on-wood-cubes-260nw-2037828293.jpg")!
  ]
  @Binding var urls: [URL]
  var body: some View {
    VStack {
      SUCollectionView(data: $urls) { row in
        urls.remove(at: row)
      } onDeleteAt: { row in
        urls.remove(at: row)
      }.padding()
        .frame(height: 100)
      Button("add") {
        urls.append(mock[Int.random(in: 0 ..< mock.count)])
      }
    }
  }
}

#Preview {
  CollectionView(urls: .constant([
    URL(string: "https://t3.ftcdn.net/jpg/01/42/62/84/360_F_142628436_BdXXMV34Xf665lwSRmBbAVICjFXh7vG9.jpg")!,
    URL(string: "https://cdn.pixabay.com/photo/2014/06/03/19/38/test-361512_640.jpg")!,
    URL(string: "https://www.researchgate.net/publication/224624453/figure/fig1/AS:393833717223438@1470908683517/Original-colour-bar-static-test-image-used-in-analogue-television-II-METHODOLOGY.png")!,
    URL(string: "https://static6.depositphotos.com/1014550/624/i/450/depositphotos_6240474-stock-photo-test-word-on-keyboard.jpg")!,
    URL(string: "https://colortest.page/wp-content/uploads/2023/05/color-image-print-test-page-pdf.jpg")!,
    URL(string: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSqQXCfw2Ulfrfe1xG2NGkSe7FOnT0h9AEjcQ&s")!,
    URL(string: "https://www.shutterstock.com/image-photo/word-test-on-wood-cubes-260nw-2037828293.jpg")!
  ]))
}


