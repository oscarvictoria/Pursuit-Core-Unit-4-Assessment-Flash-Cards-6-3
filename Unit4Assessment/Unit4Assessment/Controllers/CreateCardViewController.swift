//
//  CreateCardViewController.swift
//  Unit4Assessment
//
//  Created by Oscar Victoria Gonzalez  on 2/11/20.
//  Copyright © 2020 Alex Paul. All rights reserved.
//

import UIKit
import DataPersistence

class CreateCardViewController: UIViewController {
    
    public var dataPersistance: DataPersistence<FlashCards>!
    
    var cardObject = [FlashCards]()
    
    var createView = CreateView()
    
    override func loadView() {
        view = createView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGreen
        configureNavBar()
    }
    
    func configureNavBar() {
    navigationItem.title = "Create Card"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancel))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Create", style: .plain, target: self, action: #selector(create))
    }
    
    @objc private func create() {
        let cardObject = FlashCards(id: "0", quizTitle: "Test Tile", facts: ["Some Facts"])
        do {
            try dataPersistance.createItem(cardObject)
        } catch {
            print("could not get card")
        }
    }
    
    @objc private func cancel() {
        print("Cancel button pressed")
    }
    
}
