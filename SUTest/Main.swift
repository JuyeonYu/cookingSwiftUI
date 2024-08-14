//
//  Main.swift
//  SUTest
//
//  Created by  유 주연 on 8/10/24.
//

import SwiftUI
import Kingfisher

struct Main: View {
  
  @State var  items: [String] = [
    "State & Binding",
    "State & Binding with nested Struct",
    "StateObject & OnservedObject",
    "move item in ScrollView with HStackView",
    "import UICollectionView"
  ]
  
  @State var show1: Bool = false
  @State var show2: Bool = false
  @State var show3: Bool = false
  @State var show4: Bool = false
  @State var show5: Bool = false

  @State var urls: [URL] = [
    URL(string: "https://t3.ftcdn.net/jpg/01/42/62/84/360_F_142628436_BdXXMV34Xf665lwSRmBbAVICjFXh7vG9.jpg")!,
    URL(string: "https://cdn.pixabay.com/photo/2014/06/03/19/38/test-361512_640.jpg")!,
    URL(string: "https://www.researchgate.net/publication/224624453/figure/fig1/AS:393833717223438@1470908683517/Original-colour-bar-static-test-image-used-in-analogue-television-II-METHODOLOGY.png")!,
    URL(string: "https://static6.depositphotos.com/1014550/624/i/450/depositphotos_6240474-stock-photo-test-word-on-keyboard.jpg")!,
    URL(string: "https://colortest.page/wp-content/uploads/2023/05/color-image-print-test-page-pdf.jpg")!,
    URL(string: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSqQXCfw2Ulfrfe1xG2NGkSe7FOnT0h9AEjcQ&s")!,
    URL(string: "https://www.shutterstock.com/image-photo/word-test-on-wood-cubes-260nw-2037828293.jpg")!

  ]

    var body: some View {
      List {
        ForEach(items, id: \.self) { item in
          Button(item) {
            if item == items[0] {
              show1 = true
            } else if item == items[1] {
              show2 = true
            } else if item == items[2] {
              show3 = true
            } else if item == items[3] {
              show4 = true
            } else if item == items[4] {
              show5 = true
            }
          }
        }
        .sheet(isPresented: $show1, content: {
          StateView()
        })
        .sheet(isPresented: $show2, content: {
          StateViewWithNestedStruct()
        })
        .sheet(isPresented: $show3, content: {
          StateObjectView()
        })
        .sheet(isPresented: $show4, content: {
          HScrollView(urls: $urls)
        })
        .sheet(isPresented: $show5, content: {
          CollectionView(urls: $urls)
        })
      }
    }
}

#Preview {
    Main()
}

import Foundation
import SwiftUI

// UICollectionView를 SwiftUI에서 사용하기 위한 UIViewControllerRepresentable 구현
struct SUCollectionView: UIViewControllerRepresentable {
    @Binding var data: [URL]
    var onItemSelected: (Int) -> Void
    var onDeleteAt: (Int) -> Void
//    var update: ([URL]) -> Void

    // UICollectionViewController 생성
    func makeUIViewController(context: Context) -> UICollectionViewController {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let viewController = UICollectionViewController(collectionViewLayout: layout)
        viewController.collectionView.backgroundColor = .white
        viewController.collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        viewController.collectionView.dataSource = context.coordinator
        viewController.collectionView.delegate = context.coordinator
        
        
        viewController.collectionView.register(ImageAttachmentCollectionViewCell.self, forCellWithReuseIdentifier: "ImageAttachmentCollectionViewCell")
        return viewController
    }
    
    // UICollectionViewController 업데이트
    func updateUIViewController(_ uiViewController: UICollectionViewController, context: Context) {
        // 데이터 업데이트가 필요한 경우 여기에 추가        uiViewController.collectionView.reloadData()

      uiViewController.collectionView.reloadData()

    }
    
    // Coordinator 생성
    func makeCoordinator() -> Coordinator {
      Coordinator(parent: self, data: data, onItemSelected: onItemSelected, onDeleteAt: onDeleteAt)
    }
    
    // Coordinator 클래스
    class Coordinator: NSObject, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, ImageAttachmentCollectionViewCellDelegate {
      var parent: SUCollectionView

        var data: [URL]
        var onItemSelected: (Int) -> Void
        var onDeleteAt: (Int) -> Void
        
        init(
          parent: SUCollectionView,
            data: [URL],
            onItemSelected: @escaping (Int) -> Void,
            onDeleteAt: @escaping (Int) -> Void
        ) {
          self.parent = parent
            self.data = data
            self.onItemSelected = onItemSelected
            self.onDeleteAt = onDeleteAt
        }
        
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
          parent.data.count
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageAttachmentCollectionViewCell", for: indexPath) as! ImageAttachmentCollectionViewCell
            cell.indexPath = indexPath
          let asset = parent.data[indexPath.row]
            
            cell.imageView.kf.setImage(with: asset)
            
            cell.delete.addAction(.init(handler: { [weak self] action in
                guard let self = self else { return }
                self.data.remove(at: indexPath.row)
                collectionView.deleteItems(at: [indexPath])
                
                self.onDeleteAt(indexPath.row)
            }), for: .touchUpInside)
            
            return cell
        }

        
        func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            onItemSelected(indexPath.item)
        }
        
        // 아이템 크기 설정
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            return CGSize(width: 100, height: 100)
        }
        func collectionView(_ collectionView: UICollectionView,
                            moveItemAt sourceIndexPath: IndexPath,
                            to destinationIndexPath: IndexPath) {
            collectionView.reloadData()
//            data.move(fromOffsets: .init(integer: sourceIndexPath.row), toOffset: destinationIndexPath.row)
        }
        
        func onDelete(row: Int) {
            data.remove(at: row)
//            self.onDeleteAt(row)
//            self.onDeleteAt = {
//                self.onDeleteAt
//            }
        }
    }
}


protocol ImageAttachmentCollectionViewCellDelegate: AnyObject {
    func onDelete(row: Int)
}

class ImageAttachmentCollectionViewCell: UICollectionViewCell {
    var indexPath: IndexPath?
    weak var delegate: ImageAttachmentCollectionViewCellDelegate?
    let imageView = UIImageView()
    let delete = UIButton()
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(imageView)
        self.addSubview(delete)
      imageView.clipsToBounds = true
      
      imageView.contentMode = .scaleAspectFill
      
      imageView.translatesAutoresizingMaskIntoConstraints = false
      [imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
       imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
       imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
              imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
imageView.widthAnchor.constraint(equalToConstant: 88),
       imageView.heightAnchor.constraint(equalToConstant: 88)].forEach { $0.isActive = true
      }
      
      delete.translatesAutoresizingMaskIntoConstraints = false
      [delete.topAnchor.constraint(equalTo: contentView.topAnchor),
       delete.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
       delete.widthAnchor.constraint(equalToConstant: 24),
       delete.heightAnchor.constraint(equalToConstant: 24)].forEach { $0.isActive = true
      }
      
        
        delete.addAction(.init(handler: { _ in
            guard let row = self.indexPath?.row else { return }
            self.delegate?.onDelete(row: row)
        }), for: .touchUpInside)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
