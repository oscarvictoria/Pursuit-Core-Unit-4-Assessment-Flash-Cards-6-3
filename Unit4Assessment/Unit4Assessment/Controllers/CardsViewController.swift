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
            DispatchQueue.main.async {
                self.cardView.collectionView.reloadData()
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        loadSavedCards()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .orange
        cardView.collectionView.dataSource = self
        cardView.collectionView.delegate = self
        cardView.collectionView.register(FavoritesCell.self, forCellWithReuseIdentifier: "cardCell")
    }
    
    func loadSavedCards() {
        do {
            cards = try dataPersistance.loadItems().reversed()
        } catch {
            print("error")
        }
        
    }
    
    
    func deleteCard(indexPath: IndexPath, card: FlashCards) {
        dataPersistance.synchronize(cards)
        
        do {
            cards = try dataPersistance.loadItems()
        } catch {
            print("error")
        }
        
        cards.remove(at: indexPath.row)
        
        do {
            try dataPersistance.deleteItem(at: indexPath.row)
            
        } catch {
            print("error")
        }
    }
    
    
}

extension CardsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cards.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cardCell", for: indexPath) as? FavoritesCell else {
            fatalError("error, could not get cell")
        }
        
        let card = cards[indexPath.row]
        cell.configure(for: card)
        cell.backgroundColor = .systemRed
        cell.delegate = self
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
        loadSavedCards()
    }
    
    func didDeleteItem<T>(_ persistenceHelper: DataPersistence<T>, item: T) where T : Decodable, T : Encodable, T : Equatable {
        loadSavedCards()
    }
}

extension CardsViewController: SavedCardCellDelegate {
    func didSelectMoreButton(savedCardCell: FavoritesCell, card: FlashCards ) {
        guard let indexPath = cardView.collectionView.indexPath(for: savedCardCell) else {
            return
        }
        
        let cardObject = cards[indexPath.row]
        
        
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        let deleteAction = UIAlertAction(title: "Delete", style: .destructive)  { alertAction in
            self.deleteCard(indexPath: indexPath, card: cardObject)
            let searchCell = CardCell()
            searchCell.addButton.isHidden = false
            
            
        }
        
        alertController.addAction(cancelAction)
        alertController.addAction(deleteAction)
        present(alertController, animated: true)
        
    }
    
}


