//
//  Question.swift
//  millionaireGame
//
//  Created by Vasiliy Kapyshkov on 13.06.2021.
//

import Foundation

struct Question: Codable {
    let question: String
    let answers: [String]
    let correctAnswerIndex: Int
}
