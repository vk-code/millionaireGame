//
//  GameSession.swift
//  millionaireGame
//
//  Created by Vasiliy Kapyshkov on 13.06.2021.
//

import Foundation

class GameSession {
    var totalQuestions: Int
    var correctAnswers = Observable<Int>(0)
    private var isStoppedByGamer = false
    private let maxReward: Float = 1000000
    private var rewardPerQuestion: Int = 0
    private var reward: Int {
        
        if isStoppedByGamer && correctAnswers.value > 0 || totalQuestions == correctAnswers.value {
            return totalQuestions == correctAnswers.value ? Int(maxReward) : correctAnswers.value*rewardPerQuestion
        } else {
            return 0
        }
    }
    
    init(totalQuestions: Int) {
        self.totalQuestions = totalQuestions
        self.rewardPerQuestion = Int(maxReward / Float(totalQuestions))
    }
    
    func calcReward() -> Int {
        return correctAnswers.value > 0 ? correctAnswers.value*rewardPerQuestion : 0
    }
}


extension GameSession: GameDataDelegate {
    func increaseCorrectAnswer() {
        self.correctAnswers.value += 1
    }
    
    func getReward() -> Int {
        return correctAnswers.value*rewardPerQuestion
    }
    
    func stopByUser() {
        self.isStoppedByGamer = true
    }
    
    func saveResult() {
        DispatchQueue.global().async {
            let newResult = GameResult(date: Date(), correctAnswers: self.correctAnswers.value, reward: self.reward)
            let resultsCaretaker = ResultsCaretaker()
            var results = resultsCaretaker.load() ?? []
            results.append(newResult)
            resultsCaretaker.save(items: results)
        }
    }
}
