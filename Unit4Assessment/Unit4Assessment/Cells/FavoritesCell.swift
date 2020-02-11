//
//  FavoritesCell.swift
//  Unit4Assessment
//
//  Created by Oscar Victoria Gonzalez  on 2/11/20.
//  Copyright © 2020 Alex Paul. All rights reserved.
//

import UIKit

protocol SavedCardCellDelegate: AnyObject {
    func didSelectMoreButton(savedCardCell: FavoritesCell, card: FlashCards)
}

class FavoritesCell: UICollectionViewCell {
    
    public lazy var longPressGesture: UILongPressGestureRecognizer = {
        let gesture = UILongPressGestureRecognizer()
        gesture.addTarget(self, action: #selector(didLongPress(_:)))
        return gesture
    }()
    
    public var currentCard: FlashCards!
    
    weak var delegate: SavedCardCellDelegate?
    
    public lazy var moreButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(systemName: "ellipsis.circle"), for: .normal)
        button.addTarget(self, action: #selector(moreButtonPressed), for: .touchUpInside)
        return button
    }()
    
    public lazy var cardTitle: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        label.text = "Hello World"
        label.textAlignment = .center
        label.numberOfLines = 0
//        label.alpha = 0
        return label
    }()
    
    public lazy var cardLabels: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        label.numberOfLines = 0
        label.text = "Hello World"
        label.alpha = 0
        return label
    }()
    
    private var isShowingImage = false
    
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        commonInit()

    }
    
    required init?(coder: NSCoder) {
        super.init(coder:coder)
        commonInit()
    }
    
  @objc private func moreButtonPressed() {
    delegate?.didSelectMoreButton(savedCardCell: self, card: currentCard)
    }
    
    
   @objc private func didLongPress(_ gesture: UILongPressGestureRecognizer) {
       if gesture.state == .began || gesture.state == .changed {
           return
       }
       
       isShowingImage.toggle()
       animate()
   }
    
    private func animate() {
        let duration: Double = 2.0
        if isShowingImage {
            UIView.transition(with: self, duration: duration, options: [.transitionFlipFromLeft], animations: {
                self.cardLabels.alpha = 1.0
                self.cardTitle.alpha = 0.0
            }, completion: nil)
        } else {
            UIView.transition(with: self, duration: duration, options: [.transitionFlipFromLeft], animations: {
                self.cardLabels.alpha = 0.0
                self.cardTitle.alpha = 1.0
            }, completion: nil)
        }
        
    }
    
    private func commonInit() {
        configureButton()
        configureTitleLabel()
        configureCardLabels()
        addGestureRecognizer(longPressGesture)
    }
    
    private func configureTitleLabel() {
        addSubview(cardTitle)
        cardTitle.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            cardTitle.topAnchor.constraint(equalTo: topAnchor, constant: 100),
            cardTitle.leadingAnchor.constraint(equalTo: leadingAnchor),
            cardTitle.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
    private func configureButton() {
        addSubview(moreButton)
        moreButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            moreButton.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            moreButton.trailingAnchor.constraint(equalTo: trailingAnchor,constant: -8),
            moreButton.heightAnchor.constraint(equalToConstant: 32),
            moreButton.widthAnchor.constraint(equalTo:  moreButton.heightAnchor)
        ])
    }
    
    private func configureCardLabels() {
        addSubview(cardLabels)
        cardLabels.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            cardLabels.topAnchor.constraint(equalTo: moreButton.bottomAnchor, constant: 20),
            cardLabels.leadingAnchor.constraint(equalTo: leadingAnchor),
            cardLabels.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
    public func configure(for card: FlashCards) {
        currentCard = card
        cardTitle.text = card.quizTitle
        cardLabels.text = """
1. \(card.facts[0])
        
2. \(card.facts[1])
"""
    }
}

