//
//  QuestionsBuilder.swift
//  millionaireGame
//
//  Created by Vasiliy Kapyshkov on 17.06.2021.
//

import Foundation

class QuestionBuilder {
    private var questions: [Question] = []
    private var question: String?
    private var answers: [String] = []
    private var correctAnswer: String?
    
    func setQuestion(text: String?) {
        question = text
    }
    
    func setAnswer(text: String?) {
        guard let answerText = text else { return }
        answers.append(answerText)
    }
    
    func setCorrectAnswer(text: String?) {
        correctAnswer = text
    }
    
    private func setQuestion(question: String, answers: [String], correctAnswerIndex: Int) {
        questions.append(Question(question: question, answers: answers, correctAnswerIndex: correctAnswerIndex))
    }
    
    func build() -> Question? {
        guard let _ = question else { return nil }
        guard let _ = correctAnswer else { return nil }
        guard answers.count == 4 else { return nil }
        
        var correctAnswerIndex: Int?
        
        for (i, answer) in answers.enumerated() {
            if answer == correctAnswer {
                correctAnswerIndex = i
                break
            }
        }
        
        guard let correctIndex = correctAnswerIndex else { return nil  }
        
        let questionItem = Question(question: question!, answers: answers, correctAnswerIndex: correctIndex)
        
        correctAnswerIndex = nil
        question = nil
        correctAnswer = nil
        answers.removeAll()
        
        return questionItem
    }
}
