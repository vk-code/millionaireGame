//
//  DifficultyStrategyProtocol.swift
//  millionaireGame
//
//  Created by Vasiliy Kapyshkov on 16.06.2021.
//

import Foundation

protocol DifficultyStrategyProtocol {
    func questionsOrder(questions: inout [Question])
}
