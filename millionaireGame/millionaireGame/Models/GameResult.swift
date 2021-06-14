//
//  GameResult.swift
//  millionaireGame
//
//  Created by Vasiliy Kapyshkov on 13.06.2021.
//

import Foundation

struct GameResult: Codable {
    let date: Date
    let correctAnswers: Int
    let reward: Int
}
