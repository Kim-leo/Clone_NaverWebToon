//
//  TabbarVC.swift
//  Clone_NaverWebToon
//
//  Created by 김승현 on 2023/08/06.
//

import UIKit

class TabbarVC: UITabBarController {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tabBar.backgroundColor = .darkGray
        tabBar.tintColor = .white
        tabBar.unselectedItemTintColor = .white
        let firstVC = UINavigationController(rootViewController: FirstViewController())
        let secondVC = UINavigationController(rootViewController: SecondViewController())
        let thirdVC = UINavigationController(rootViewController: ThirdViewController())
        let forthVC = UINavigationController(rootViewController: ForthViewController())
        let fifthVC = UINavigationController(rootViewController: FifthViewController())
        
        firstVC.tabBarItem.selectedImage = UIImage(systemName: "calendar.circle.fill")
        firstVC.tabBarItem.title = "웹툰"
        firstVC.tabBarItem.image = UIImage(systemName: "calendar.circle")
        
        secondVC.tabBarItem.selectedImage = UIImage(systemName: "book.closed.fill")
        secondVC.tabBarItem.title = "추천완결"
        secondVC.tabBarItem.image = UIImage(systemName: "book.closed")
        
        thirdVC.tabBarItem.selectedImage = UIImage(systemName: "star.square.fill")
        thirdVC.tabBarItem.title = "베스트도전"
        thirdVC.tabBarItem.image = UIImage(systemName: "star.square")
        
        forthVC.tabBarItem.selectedImage = UIImage(systemName: "smiley.fill")
        forthVC.tabBarItem.title = "MY"
        forthVC.tabBarItem.image = UIImage(systemName: "smiley")
        
        fifthVC.tabBarItem.selectedImage = UIImage(systemName: "square.grid.2x2.fill")
        fifthVC.tabBarItem.title = "더보기"
        fifthVC.tabBarItem.image = UIImage(systemName: "square.grid.2x2")
        
        
     
        viewControllers = [firstVC, secondVC, thirdVC, forthVC, fifthVC]
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    

    

}
