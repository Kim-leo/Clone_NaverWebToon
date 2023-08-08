//
//  TestViewController.swift
//  Clone_NaverWebToon
//
//  Created by 김승현 on 2023/08/08.
//

import UIKit

class TestViewController: UIViewController {
    
    var nowPage: Int = 0
    
    lazy var topView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray
        return view
    }()
    
    lazy var numLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
//        label.text = "\(nowPage + 1) / 5"
        label.textColor = .white
        label.backgroundColor = .darkGray
        label.alpha = 0.8
        label.clipsToBounds = true
        label.layer.cornerRadius = 10
        label.font = UIFont.systemFont(ofSize: 15)
        return label
    }()
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout.init()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
//        layout.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        layout.footerReferenceSize = .zero
        layout.headerReferenceSize = .zero
        
        let v = UICollectionView(frame: .zero, collectionViewLayout: layout)
        v.isScrollEnabled = false
        v.isPagingEnabled = true
        v.showsHorizontalScrollIndicator = false
        v.register(TestCell.self, forCellWithReuseIdentifier: "TestCell")
        return v
    }()
    
    
    let colorArrays: [UIColor] = [.systemRed, .systemOrange, .systemYellow, .systemGreen, .systemBlue]
    let colorArrays2: [UIColor] = [.systemGreen, .systemBlue, .systemRed, .systemMint, .systemPink]
    let sampleImages = [UIImage(systemName:"house"), UIImage(systemName:"pencil"), UIImage(systemName:"folder"), UIImage(systemName:"person"), UIImage(systemName:"cloud")]
    
   

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(topView)
        topView.addSubview(numLabel)
        topView.addSubview(collectionView)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        componentsLayout()
        
        let leftSwipe: UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipteGesture(_:)))
        leftSwipe.direction = UISwipeGestureRecognizer.Direction.left
        topView.addGestureRecognizer(leftSwipe)
        
        let rightSwipe: UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipteGesture(_:)))
        rightSwipe.direction = UISwipeGestureRecognizer.Direction.right
        topView.addGestureRecognizer(rightSwipe)
        
        numLabel.text = "\(nowPage + 1) / 5"
        topView.backgroundColor = colorArrays2[nowPage]
    }
    
    @objc func respondToSwipteGesture(_ gesture: UIGestureRecognizer) {
        if let swipeGestrue = gesture as? UISwipeGestureRecognizer {
            switch swipeGestrue.direction {
            case UISwipeGestureRecognizer.Direction.left:
                print("Left")
                goToRightPage()
            case UISwipeGestureRecognizer.Direction.right:
                print("Right")
                goToLeftPage()
            default:
                break
            }
        }
        numLabel.text = "\(nowPage + 1) / 5"
//        topView.backgroundColor = colorArrays2[nowPage]
        UIView.animate(withDuration: 0.5) {
            self.topView.backgroundColor = self.colorArrays[self.nowPage]
        }
    }
    
    func goToRightPage() {
        switch nowPage {
        case colorArrays.count-1:
            print("마지막 페이지")
        default:
            collectionView.isScrollEnabled = true
            nowPage += 1
            self.collectionView.scrollToItem(at: NSIndexPath(item: nowPage, section: 0) as IndexPath, at: .right, animated: true)
            collectionView.isScrollEnabled = false
            break
        }
    }
    
    func goToLeftPage() {
        switch nowPage {
        case 0:
            print("첫 페이지")
        default:
            collectionView.isScrollEnabled = true
            nowPage -= 1
            self.collectionView.scrollToItem(at: NSIndexPath(item: nowPage, section: 0) as IndexPath, at: .left, animated: true)
            collectionView.isScrollEnabled = false
            break
        }
    }
    

}

extension TestViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        if scrollView.frame.size.width != 0 {
//            let value = Int((scrollView.contentOffset.x / scrollView.frame.width))
//            nowPage = value
//        }
//    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        nowPage = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TestCell", for: indexPath) as! TestCell
        cell.parent = self
        cell.titleView.backgroundColor = colorArrays[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width, height: collectionView.frame.size.height)
    }
    
    
    
    
    func componentsLayout() {
        topView.translatesAutoresizingMaskIntoConstraints = false
        topView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        topView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        topView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        topView.heightAnchor.constraint(equalToConstant: 250).isActive = true
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
//        collectionView.topAnchor.constraint(equalTo: topView.topAnchor, constant: 10).isActive = true
        collectionView.heightAnchor.constraint(equalToConstant: 60).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: topView.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: topView.trailingAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: topView.bottomAnchor, constant: -10).isActive = true
        
        numLabel.translatesAutoresizingMaskIntoConstraints = false
        numLabel.bottomAnchor.constraint(equalTo: collectionView.topAnchor, constant: -10).isActive = true
        numLabel.trailingAnchor.constraint(equalTo: topView.trailingAnchor, constant: -10).isActive = true
        numLabel.widthAnchor.constraint(equalToConstant: 60).isActive = true
        numLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
    }
}
