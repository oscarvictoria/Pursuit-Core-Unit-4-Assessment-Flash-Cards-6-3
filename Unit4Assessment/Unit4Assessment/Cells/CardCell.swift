//
//  CardCell.swift
//  Unit4Assessment
//
//  Created by Oscar Victoria Gonzalez  on 2/11/20.
//  Copyright © 2020 Alex Paul. All rights reserved.
//

import UIKit

protocol CardCellDelegate: AnyObject {
    func didPressSaveButton(cardCell: CardCell)
}

class CardCell: UICollectionViewCell {
    
    var currentCard: FlashCards?
    
    weak var delegate: CardCellDelegate?
    
    public lazy var addButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(systemName: "bookmark"), for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.addTarget(self, action: #selector(saveCard), for: .touchUpInside)
        return button
    }()
    
    public lazy var cardTitle: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        label.text = "Hello World"
        label.textAlignment = .center
        label.numberOfLines = 0
        label.alpha = 0
        return label
    }()
    
    public lazy var cardLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        label.numberOfLines = 0
        label.alpha = 1
        return label
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder:coder)
        commonInit()
    }
    
   @objc func saveCard() {
    delegate?.didPressSaveButton(cardCell: self)
    }

    
    private func commonInit() {
        configureAddButton()
        configureCardTtle()
        configureCardLabel()
    }
    
    private func configureAddButton() {
        addSubview(addButton)
        addButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            addButton.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            addButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            addButton.heightAnchor.constraint(equalToConstant: 40),
            addButton.widthAnchor.constraint(equalToConstant: 35)
            
        
        ])
    }
    
    private func configureCardTtle() {
        addSubview(cardTitle)
        cardTitle.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            cardTitle.topAnchor.constraint(equalTo: addButton.bottomAnchor, constant: 50),
            cardTitle.leadingAnchor.constraint(equalTo: leadingAnchor),
            cardTitle.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }

    private func configureCardLabel() {
        addSubview(cardLabel)
        cardLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            cardLabel.topAnchor.constraint(equalTo: addButton.bottomAnchor, constant: 20),
            cardLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            cardLabel.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
    public func configure(for card: FlashCards) {
        currentCard = card
        cardTitle.text = card.quizTitle
        cardLabel.text = """
1. \(card.facts[0])
        
2. \(card.facts[1])


"""
        
    }
    
}

