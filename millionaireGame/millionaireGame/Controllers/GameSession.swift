//
//  GameSession.swift
//  millionaireGame
//
//  Created by Vasiliy Kapyshkov on 13.06.2021.
//

import Foundation

class GameSession {
    private var totalQuestions: Int
    private var correctAnswers: Int = 0
    private var isStoppedByGamer = false
    private var rewards = [64000, 125000, 250000, 500000, 1000000]
    private var reward: Int {
        if isStoppedByGamer && correctAnswers > 0 || totalQuestions == correctAnswers {
            return rewards[correctAnswers-1]
        } else {
            return 0
        }
    }
    
    init(totalQuestions: Int) {
        self.totalQuestions = totalQuestions
    }
    
    func calcReward() -> Int {
        return correctAnswers > 0 ? rewards[correctAnswers-1] : 0
    }
}


extension GameSession: GameDataDelegate {
    func increaseCorrectAnswer() {
        self.correctAnswers += 1
    }
    
    func getReward() -> Int {
        return self.rewards[correctAnswers-1]
    }
    
    func stopByUser() {
        self.isStoppedByGamer = true
    }
    
    func saveResult() {
        DispatchQueue.global().async {
            let newResult = GameResult(date: Date(), correctAnswers: self.correctAnswers, reward: self.reward)
            let resultsCaretaker = ResultsCaretaker()
            var results = resultsCaretaker.load() ?? []
            results.append(newResult)
            resultsCaretaker.save(items: results)
        }
    }
}
