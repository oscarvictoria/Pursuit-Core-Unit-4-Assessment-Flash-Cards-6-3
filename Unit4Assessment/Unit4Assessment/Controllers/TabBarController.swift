//
//  TabBarController.swift
//  Unit4Assessment
//
//  Created by Oscar Victoria Gonzalez  on 2/11/20.
//  Copyright © 2020 Alex Paul. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {
    
    private lazy var cardsViewController: CardsViewController = {
      let vc = CardsViewController()
        vc.tabBarItem = UITabBarItem(title: "Cards", image: UIImage(systemName: "person"), tag: 0)
        return vc
    }()
    
    
    private lazy var createCardsViewController: CreateCardViewController = {
        let vc = CreateCardViewController()
        vc.tabBarItem = UITabBarItem(title: "Create", image: UIImage(systemName: "photo"), tag: 1)
        return vc
    }()
    
    
    private lazy var searchCardsViewController: SearchCardViewController = {
        let vc = SearchCardViewController()
        vc.tabBarItem = UITabBarItem(title: "Search", image: UIImage(systemName: "folder"), tag: 2)
        return vc
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemRed
        viewControllers = [cardsViewController, createCardsViewController, searchCardsViewController]
    }
    



}
