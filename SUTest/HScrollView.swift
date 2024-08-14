//
//  HScrollView.swift
//  SUTest
//
//  Created by  유 주연 on 8/14/24.
//

import SwiftUI
import UniformTypeIdentifiers


struct HScrollView: View {
  @Binding var urls: [URL]
    var body: some View {
      ScrollView(.horizontal) {
        HStack {
//          ForEach(urls, id: \.self) { url in
//            AsyncImage(url: url) { image in
//                image.resizable()
////                .scaledToFit()
//              } placeholder: {
//                ProgressView()
//              }
//              .frame(width: 75, height: 105)
////              .onDrag {
////                  return NSItemProvider(object: String(index) as NSString)
////              }
////              .onDrop(of: [String(kUTTypePlainText)], delegate: DropViewDelegate(currentIndex: index, items: $urls))
//              .onDrag {
//                  let itemProvider = NSItemProvider(object: urls[index] as NSURL)
//                  itemProvider.suggestedName = urls[index].lastPathComponent
//                  return itemProvider
//              }
//              .onDrop(of: [UTType.url], delegate: DropViewDelegate(currentIndex: index, items: $urls))
          
//          ForEach(urls.indices, id: \.self) { index in
//            let url = urls[index]
//            AsyncImage(url: url) { image in
//                image.resizable()
////                .scaledToFit()
//              } placeholder: {
//                ProgressView()
//              }
//              .frame(width: 75, height: 105)
////              Text(urls[index].lastPathComponent)
////                  .padding()
////                  .background(Color.blue)
////                  .foregroundColor(.white)
////                  .cornerRadius(8)
//                  .onDrag {
//                      let itemProvider = NSItemProvider(object: urls[index] as NSURL)
//                      itemProvider.suggestedName = urls[index].lastPathComponent
//                      return itemProvider
//                  }
//                  .onDrop(of: [UTType.url], delegate: DropViewDelegate(currentIndex: index, items: $urls))
//          }
          if !urls.isEmpty {
            SUCollectionView(data: $urls) { _ in
              
            } onDeleteAt: { row in
              urls.remove(at: row)
            }
          }
          





            
//            } placeholder: {
//              Image(systemName: "circle")
//                .resizable()
//                .frame(width: 80, height: 80)
//            }

              
          }
        }.background(.red)
      }
    }
  
  struct DropViewDelegate: DropDelegate {
      let currentIndex: Int
      @Binding var items: [URL]
      
      func performDrop(info: DropInfo) -> Bool {
        guard let item = info.itemProviders(for: [UTType.url]).first else { return false }

          item.loadObject(ofClass: NSString.self) { (object, error) in
              guard let string = object as? String, let sourceIndex = Int(string) else { return }
              DispatchQueue.main.async {
                  let movedItem = items[sourceIndex]
                  items.remove(at: sourceIndex)
                  items.insert(movedItem, at: currentIndex)
              }
          }
          return true
      }
  
}

#Preview {
  HScrollView(urls: .constant([
    URL(string: "https://t3.ftcdn.net/jpg/01/42/62/84/360_F_142628436_BdXXMV34Xf665lwSRmBbAVICjFXh7vG9.jpg")!,
    URL(string: "https://cdn.pixabay.com/photo/2014/06/03/19/38/test-361512_640.jpg")!,
    URL(string: "https://www.researchgate.net/publication/224624453/figure/fig1/AS:393833717223438@1470908683517/Original-colour-bar-static-test-image-used-in-analogue-television-II-METHODOLOGY.png")!,
    URL(string: "https://static6.depositphotos.com/1014550/624/i/450/depositphotos_6240474-stock-photo-test-word-on-keyboard.jpg")!,
    URL(string: "https://colortest.page/wp-content/uploads/2023/05/color-image-print-test-page-pdf.jpg")!,
    URL(string: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSqQXCfw2Ulfrfe1xG2NGkSe7FOnT0h9AEjcQ&s")!,
    URL(string: "https://www.shutterstock.com/image-photo/word-test-on-wood-cubes-260nw-2037828293.jpg")!,
//    URL(string: "")!
  ]))
}
