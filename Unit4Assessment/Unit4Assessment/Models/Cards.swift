//
//  Cards.swift
//  Unit4Assessment
//
//  Created by Oscar Victoria Gonzalez  on 2/11/20.
//  Copyright © 2020 Alex Paul. All rights reserved.
//

import Foundation

struct Cards: Codable {
    let cards: [FlashCards]
}

struct FlashCards: Codable {
    let id: String
    let cardTitle: String
    let facts: [String]
}



