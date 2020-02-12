//
//  TabBarController.swift
//  Unit4Assessment
//
//  Created by Oscar Victoria Gonzalez  on 2/11/20.
//  Copyright © 2020 Alex Paul. All rights reserved.
//

import UIKit
import DataPersistence

class TabBarController: UITabBarController {
    
//    private var dataPersistance = DataPersistence<Article>(filename: "savedArticles.plist")
    private var dataPersistance = DataPersistence<FlashCards>(filename: "savedCards.plist")
    
    
    private lazy var cardsViewController: CardsViewController = {
      let vc = CardsViewController()
        vc.tabBarItem = UITabBarItem(title: "Cards", image: UIImage(systemName: "person"), tag: 0)
        vc.dataPersistance = dataPersistance
        vc.dataPersistance.delegate = vc
        return vc
    }()
    
    
    private lazy var createCardsViewController: CreateCardViewController = {
        let vc = CreateCardViewController()
        vc.tabBarItem = UITabBarItem(title: "Create", image: UIImage(systemName: "pencil"), tag: 1)
        vc.dataPersistance = dataPersistance
        return vc
    }()
    
    
    private lazy var searchCardsViewController: SearchCardViewController = {
        let vc = SearchCardViewController()
        vc.tabBarItem = UITabBarItem(title: "Search", image: .checkmark , tag: 2)
        vc.dataPersistance = dataPersistance
        
        return vc
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemRed
        viewControllers = [cardsViewController, UINavigationController(rootViewController: createCardsViewController), searchCardsViewController]
    }
    



}
