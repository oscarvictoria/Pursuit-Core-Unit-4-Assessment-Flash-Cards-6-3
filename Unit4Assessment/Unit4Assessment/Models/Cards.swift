//
//  Cards.swift
//  Unit4Assessment
//
//  Created by Oscar Victoria Gonzalez  on 2/11/20.
//  Copyright © 2020 Alex Paul. All rights reserved.
//

import Foundation


struct FlashCards: Codable & Equatable {
    let id: String
    let quizTitle: String
    let facts: [String]
}

extension FlashCards {
    static func getData() -> [FlashCards] {
        var card = [FlashCards]()
        guard let fileURL = Bundle.main.url(forResource: "Cards", withExtension: "json") else {
            fatalError("could not locate json file")
        }
        
        do {
            let data = try Data(contentsOf: fileURL)
            let cardData = try JSONDecoder().decode([FlashCards].self, from: data)
            card = cardData
        } catch {
            print("failed to load contents \(error)")
        }
        
        return card
    }
}




