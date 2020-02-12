//
//  SearchCardViewController.swift
//  Unit4Assessment
//
//  Created by Oscar Victoria Gonzalez  on 2/11/20.
//  Copyright © 2020 Alex Paul. All rights reserved.
//

import UIKit
import DataPersistence

class SearchCardViewController: UIViewController {
    
    public var dataPersistance: DataPersistence<FlashCards>!
    
    var searchView = SearchView()
    
    override func loadView() {
        view = searchView
    }
    
    var cards = [FlashCards]() {
        didSet {
            DispatchQueue.main.async {
                self.searchView.collectionView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemPurple
        searchView.collectionView.dataSource = self
        searchView.collectionView.delegate = self
        searchView.collectionView.register(CardCell.self, forCellWithReuseIdentifier: "cardCell")
        loadCards()
    }
    
    func loadCards() {
        cards = FlashCards.getData()
    }
    
}

extension SearchCardViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cards.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cardCell", for: indexPath) as? CardCell else {
            fatalError("could not get cell")
        }
        
        let card = cards[indexPath.row]
        cell.configure(for: card)
        cell.backgroundColor = .systemBackground
        cell.delegate = self
        return cell
        
    }
}

extension SearchCardViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let maxSize: CGSize = UIScreen.main.bounds.size
        let itemWidth: CGFloat = maxSize.width
        let itemHeight: CGFloat = maxSize.height * 0.30
        return CGSize(width: itemWidth, height: itemHeight)
    }
}

extension SearchCardViewController: CardCellDelegate {
    func didPressSaveButton(cardCell: CardCell) {
        guard let indexPath = searchView.collectionView.indexPath(for: cardCell) else {
            return
        }
        
        let cardObject = cards[indexPath.row]
        
        do {
            let oldItems = try dataPersistance.loadItems()
            if oldItems.contains(cardObject) {
                let alert = UIAlertController(title: "Card is saved already", message: "No need to bookmark!", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                self.present(alert, animated: true)
            } else {
                let itemHasBeenSaved = dataPersistance.hasItemBeenSaved(cardObject)
                if itemHasBeenSaved == true {
                } else {
                    try dataPersistance.createItem(cardObject)
                    let alert = UIAlertController(title: "Card saved", message: "The card was succesfully saved to your flash cards", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                    self.present(alert, animated: true)
                }
            }
        } catch {
            print("error")
        }
    }
}


