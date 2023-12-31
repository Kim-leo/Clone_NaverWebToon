//
//  TestViewController.swift
//  Clone_NaverWebToon
//
//  Created by 김승현 on 2023/08/08.
//

import UIKit

class TestViewController: UIViewController {
    
    var nowPage: Int = 0
    let colorArrays: [UIColor] = [.systemRed, .systemOrange, .systemYellow, .systemGreen, .systemBlue]
    let colorArrays2: [UIColor] = [.systemGreen, .systemBlue, .systemRed, .systemMint, .systemPink]
    let sampleImages = [UIImage(systemName:"house"), UIImage(systemName:"pencil"), UIImage(systemName:"folder"), UIImage(systemName:"person"), UIImage(systemName:"cloud")]
    
    lazy var topView: UIView = {
        let view = UIView()
        view.backgroundColor = colorArrays.first
        return view
    }()
    
    lazy var numLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "\(nowPage + 1) / 5"
        label.textColor = .white
        label.backgroundColor = .darkGray
        label.alpha = 0.8
        label.clipsToBounds = true
        label.layer.cornerRadius = 10
        label.font = UIFont.systemFont(ofSize: 15)
        return label
    }()
    
    lazy var topCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout.init()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
//        layout.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        layout.footerReferenceSize = .zero
        layout.headerReferenceSize = .zero
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.isScrollEnabled = false
        cv.isPagingEnabled = true
        cv.showsHorizontalScrollIndicator = false
        cv.register(TopCell.self, forCellWithReuseIdentifier: "TopCell")
        return cv
    }()
    
    lazy var weekCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout.init()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.footerReferenceSize = .zero
        layout.headerReferenceSize = .zero
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.isScrollEnabled = true
        cv.isPagingEnabled = true
        cv.showsHorizontalScrollIndicator = false
        cv.register(WeekCell.self, forCellWithReuseIdentifier: "WeekCell")
        cv.backgroundColor = .systemBlue
        return cv
    }()
    
    
   

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(topView)
        topView.addSubview(numLabel)
        topView.addSubview(topCollectionView)
        self.view.addSubview(weekCollectionView)
        
        topCollectionView.delegate = self
        topCollectionView.dataSource = self
        componentsLayout()
        
        let leftSwipe: UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipteGesture(_:)))
        leftSwipe.direction = UISwipeGestureRecognizer.Direction.left
        topView.addGestureRecognizer(leftSwipe)
        
        let rightSwipe: UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipteGesture(_:)))
        rightSwipe.direction = UISwipeGestureRecognizer.Direction.right
        topView.addGestureRecognizer(rightSwipe)
        
        
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
            topCollectionView.isScrollEnabled = true
            nowPage += 1
            self.topCollectionView.scrollToItem(at: NSIndexPath(item: nowPage, section: 0) as IndexPath, at: .right, animated: true)
            topCollectionView.isScrollEnabled = false
            break
        }
    }
    
    func goToLeftPage() {
        switch nowPage {
        case 0:
            print("첫 페이지")
        default:
            topCollectionView.isScrollEnabled = true
            nowPage -= 1
            self.topCollectionView.scrollToItem(at: NSIndexPath(item: nowPage, section: 0) as IndexPath, at: .left, animated: true)
            topCollectionView.isScrollEnabled = false
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
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TopCell", for: indexPath) as! TopCell
//        cell.parent = self
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
        
        topCollectionView.translatesAutoresizingMaskIntoConstraints = false
//        collectionView.topAnchor.constraint(equalTo: topView.topAnchor, constant: 10).isActive = true
        topCollectionView.heightAnchor.constraint(equalToConstant: 60).isActive = true
        topCollectionView.leadingAnchor.constraint(equalTo: topView.leadingAnchor).isActive = true
        topCollectionView.trailingAnchor.constraint(equalTo: topView.trailingAnchor).isActive = true
        topCollectionView.bottomAnchor.constraint(equalTo: topView.bottomAnchor, constant: -10).isActive = true
        
        numLabel.translatesAutoresizingMaskIntoConstraints = false
        numLabel.bottomAnchor.constraint(equalTo: topCollectionView.topAnchor, constant: -10).isActive = true
        numLabel.trailingAnchor.constraint(equalTo: topView.trailingAnchor, constant: -10).isActive = true
        numLabel.widthAnchor.constraint(equalToConstant: 60).isActive = true
        numLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        weekCollectionView.translatesAutoresizingMaskIntoConstraints = false
        weekCollectionView.topAnchor.constraint(equalTo: topView.bottomAnchor).isActive = true
        weekCollectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        weekCollectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        weekCollectionView.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
}
