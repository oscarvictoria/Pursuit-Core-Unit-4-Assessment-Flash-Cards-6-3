//
//  ViewController.swift
//  Unit4Assessment
//
//  Created by Alex Paul on 2/11/20.
//  Copyright © 2020 Alex Paul. All rights reserved.
//

import UIKit
import DataPersistence

class CardsViewController: UIViewController {
    
    public var dataPersistance: DataPersistence<FlashCards>!
    
    
    var cardView = CardView()
    
    override func loadView() {
        view = cardView
    }
    
    var cards = [FlashCards]() {
        didSet {
            print("\(cards.count) card was saved")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .orange
        cardView.collectionView.dataSource = self
        cardView.collectionView.delegate = self
        cardView.collectionView.register(FavoritesCell.self, forCellWithReuseIdentifier: "cardCell")
        loadSavedCards()
    }
    
    func loadSavedCards() {
        do {
            cards = try dataPersistance.loadItems().reversed()
        } catch {
            print("error")
        }
        
    }
    
    
}

extension CardsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cardCell", for: indexPath) as? FavoritesCell else {
            fatalError("error, could not get cell")
        }
        cell.backgroundColor = .systemRed
        return cell
    }
}

extension CardsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let maxSize: CGSize = UIScreen.main.bounds.size
        let itemWidth: CGFloat = maxSize.width
        let itemHeight: CGFloat = maxSize.height * 0.30
        return CGSize(width: itemWidth, height: itemHeight)
    }
}

extension CardsViewController: DataPersistenceDelegate {
    func didSaveItem<T>(_ persistenceHelper: DataPersistence<T>, item: T) where T : Decodable, T : Encodable, T : Equatable {
        print("item was saved")
    }
    
    func didDeleteItem<T>(_ persistenceHelper: DataPersistence<T>, item: T) where T : Decodable, T : Encodable, T : Equatable {
        print("item was deleted")
    }
}
