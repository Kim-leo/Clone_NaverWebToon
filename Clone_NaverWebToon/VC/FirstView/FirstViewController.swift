//
//  FirstViewController.swift
//  Clone_NaverWebToon
//
//  Created by 김승현 on 2023/08/06.
//

import UIKit

class FirstViewController: UIViewController {
    
    // MARK: - Variables
    var nowPage: Int = 0
    var weekChosenPage: Int = 0
    let colorArrays: [UIColor] = [.systemRed, .systemOrange, .systemYellow, .systemGreen, .systemBlue]
    let colorArrays2: [UIColor] = [.systemGreen, .systemBlue, .systemRed, .systemMint, .systemPink]
    let sampleImages = [UIImage(systemName:"house"), UIImage(systemName:"pencil"), UIImage(systemName:"folder"), UIImage(systemName:"person"), UIImage(systemName:"cloud")]
    let weekTextArrays: [String] = ["신작", "매일+", "월", "화", "수", "목", "금", "토", "일", "완결"]
    
    //MARK: - UI Components
    lazy var entireScrollView: UIScrollView = {
        let sv = UIScrollView()
        sv.backgroundColor = .darkGray
        return sv
    }()
    
    lazy var contentView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
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
        label.backgroundColor = .clear
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
        cv.tag = 0
        cv.isScrollEnabled = false
        cv.isPagingEnabled = true
        cv.showsHorizontalScrollIndicator = false
        cv.register(TopCell.self, forCellWithReuseIdentifier: "TopCell")
        return cv
    }()
    
    lazy var weekCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout.init()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 0
        layout.footerReferenceSize = .zero
        layout.headerReferenceSize = .zero
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.tag = 1
        cv.isScrollEnabled = true
        cv.isPagingEnabled = true
        cv.showsHorizontalScrollIndicator = false
        cv.register(WeekCell.self, forCellWithReuseIdentifier: "WeekCell")
        cv.backgroundColor = .darkGray
        return cv
    }()
    
    lazy var thinDividingLine: UIView = {
        let v = UIView()
        v.backgroundColor = .lightGray
        return v
    }()
    
    lazy var weekDayCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout.init()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.footerReferenceSize = .zero
        layout.headerReferenceSize = .zero
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.tag = 2
        cv.isPagingEnabled = true
        cv.isPagingEnabled = true
        cv.showsHorizontalScrollIndicator = false
        cv.register(WeekDayCell.self, forCellWithReuseIdentifier: "WeekDayCell")
        cv.backgroundColor = .lightGray
        return cv
    }()
    
    lazy var middleAdView: UIImageView = {
        let v = UIImageView()
        v.backgroundColor = .systemOrange
        v.layer.masksToBounds = true
        v.layer.cornerRadius = 5
        return v
    }()
    
    lazy var eachDayCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout.init()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 0
        layout.footerReferenceSize = .zero
        layout.headerReferenceSize = .zero
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.tag = 3
        cv.isPagingEnabled = true
        cv.isPagingEnabled = true
        cv.showsHorizontalScrollIndicator = false
//        cv.register(<#T##cellClass: AnyClass?##AnyClass?#>, forCellWithReuseIdentifier: <#T##String#>)
        cv.backgroundColor = .lightGray
        return cv
    }()
    
    
    
    //MARK: - View Life Cycle
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = true
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .white
        
        addComponentsInView()
        componentsLayout()
        recognizingGestures()
        
    }
    
    
    
}

extension FirstViewController {
    func addComponentsInView() {
        
        self.view.addSubview(entireScrollView)
        entireScrollView.addSubview(contentView)
        
        contentView.addSubview(topView)
        topView.addSubview(numLabel)
        topView.addSubview(topCollectionView)
        contentView.addSubview(weekCollectionView)
        contentView.addSubview(thinDividingLine)
        contentView.addSubview(weekDayCollectionView)
        
//        weekDayCollectionView.addSubview(middleAdView)
//        weekDayCollectionView.addSubview(eachDayCollectionView)
        
        topCollectionView.delegate = self
        topCollectionView.dataSource = self
        weekCollectionView.delegate = self
        weekCollectionView.dataSource = self
        weekDayCollectionView.delegate = self
        weekDayCollectionView.dataSource = self
    }
    
    func componentsLayout() {
        entireScrollView.translatesAutoresizingMaskIntoConstraints = false
        entireScrollView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        entireScrollView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        entireScrollView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        entireScrollView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.topAnchor.constraint(equalTo: entireScrollView.topAnchor).isActive = true
        contentView.heightAnchor.constraint(equalTo: entireScrollView.heightAnchor).isActive = true
        contentView.widthAnchor.constraint(equalTo: entireScrollView.widthAnchor).isActive = true
        contentView.leadingAnchor.constraint(equalTo: entireScrollView.leadingAnchor).isActive = true
        contentView.trailingAnchor.constraint(equalTo: entireScrollView.trailingAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: entireScrollView.bottomAnchor).isActive = true
        
        topView.translatesAutoresizingMaskIntoConstraints = false
        topView.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor).isActive = true
        topView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        topView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
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
        weekCollectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 1).isActive = true
        weekCollectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -1).isActive = true
        weekCollectionView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        thinDividingLine.translatesAutoresizingMaskIntoConstraints = false
        thinDividingLine.topAnchor.constraint(equalTo: weekCollectionView.bottomAnchor).isActive = true
        thinDividingLine.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        thinDividingLine.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        thinDividingLine.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        weekDayCollectionView.translatesAutoresizingMaskIntoConstraints = false
        weekDayCollectionView.topAnchor.constraint(equalTo: thinDividingLine.bottomAnchor).isActive = true
        weekDayCollectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        weekDayCollectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        weekDayCollectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        
//        middleAdView.translatesAutoresizingMaskIntoConstraints = false
//        middleAdView.topAnchor.constraint(equalTo: weekDayCollectionView.topAnchor, constant: 10).isActive = true
//        middleAdView.leadingAnchor.constraint(equalTo: weekDayCollectionView.leadingAnchor, constant: 10).isActive = true
//        middleAdView.trailingAnchor.constraint(equalTo: weekDayCollectionView.trailingAnchor, constant: -10).isActive = true
//        middleAdView.heightAnchor.constraint(equalToConstant: 60).isActive = true
////
//        eachDayCollectionView.translatesAutoresizingMaskIntoConstraints = false
//        eachDayCollectionView.topAnchor.constraint(equalTo: middleAdView.bottomAnchor, constant: 10).isActive = true
//        eachDayCollectionView.leadingAnchor.constraint(equalTo: weekDayCollectionView.leadingAnchor, constant: 10).isActive = true
//        eachDayCollectionView.trailingAnchor.constraint(equalTo: weekDayCollectionView.trailingAnchor, constant: -10).isActive = true
//        eachDayCollectionView.bottomAnchor.constraint(equalTo: weekDayCollectionView.bottomAnchor, constant: -10).isActive = true
    }
    
    func recognizingGestures() {
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

// MARK: - CollectionView Extension
extension FirstViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        if scrollView.frame.size.width != 0 {
//            let value = Int((scrollView.contentOffset.x / scrollView.frame.width))
//            nowPage = value
//        }
//    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        switch scrollView.tag {
        case 0:
            nowPage = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
        case 1:
            print("Hello")
        default:
            break
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView.tag {
        case 0:
            return 5
        case 1:
            return weekTextArrays.count
        case 2:
            return weekTextArrays.count
        default:
            return 0
            break
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView.tag {
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TopCell", for: indexPath) as! TopCell
            cell.parent = self
            cell.titleView.backgroundColor = colorArrays[indexPath.row]
            return cell
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WeekCell", for: indexPath) as! WeekCell
            cell.parent = self
            cell.eachCellLabel.text = "\(weekTextArrays[indexPath.row])"
            
            if indexPath.item == 0 {
                cell.isSelected = true
            } else {
                cell.isSelected = false
            }
            return cell
        case 2:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WeekDayCell", for: indexPath) as! WeekDayCell
            cell.parent = self
            
            return cell
        default:
            return UICollectionViewCell()
            break
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch collectionView.tag {
        case 0:
            return CGSize(width: collectionView.frame.size.width, height: collectionView.frame.size.height)
        case 1:
            let width = collectionView.frame.size.width / CGFloat(weekTextArrays.count)
            
            return CGSize(width: width, height: collectionView.frame.size.height)
        case 2:
            return CGSize(width: collectionView.frame.size.width, height: collectionView.frame.size.height)
        default:
            return CGSize()
            break
        }
        
    }
    
    
    
}
