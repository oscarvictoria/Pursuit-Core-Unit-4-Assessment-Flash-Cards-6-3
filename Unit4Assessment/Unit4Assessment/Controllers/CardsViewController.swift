//
//  ViewController.swift
//  Unit4Assessment
//
//  Created by Alex Paul on 2/11/20.
//  Copyright © 2020 Alex Paul. All rights reserved.
//

import UIKit

class CardsViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .orange
    CardsAPIClient.getCards { (result) in
        switch result {
        case .failure(let appError):
            print("app error \(appError)")
        case .success(let cards):
            dump(cards)
        }
    }
 
  }


}

