//
//  HardDifficultyStrategy.swift
//  millionaireGame
//
//  Created by Vasiliy Kapyshkov on 16.06.2021.
//

import Foundation

final class HardDifficultyStrategy: DifficultyStrategyProtocol {
    
    func questionsOrder(questions: inout [Question]) {
        questions.shuffle()
    }
}
