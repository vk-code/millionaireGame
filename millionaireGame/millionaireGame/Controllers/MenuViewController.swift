//
//  MenuViewController.swift
//  millionaireGame
//
//  Created by Vasiliy Kapyshkov on 13.06.2021.
//

import UIKit

class MenuViewController: UIViewController {

    @IBOutlet weak var newGameButton: UIButton!
    @IBOutlet weak var resultsButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }


    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "gameSegue":
            if let vc = segue.destination as? GameViewController {
                let questions = generateQuestions()
                let session = GameSession(totalQuestions: questions.count)
                
                switch Game.shared.difficulty {
                case .hard:
                    vc.difficultyStrategy = HardDifficultyStrategy()
                default:
                    vc.difficultyStrategy = EasyDifficultyStrategy()
                }
                
                vc.questions = questions
                vc.gameDataDelegate = session
                Game.shared.session = session
            }
        case "resultsSegue":
            return
        default:
            return
        }
    }
    
    
    private func generateQuestions() -> [Question] {
        var questions = [
            Question(question: "Назовите столицу Кении",
                     answers: ["Найроби", "Малинди", "Момбаса", "Кисуму"],
                     correctAnswerIndex: 0
            ),
            Question(question: "Какое самое высокое здание в Европе?",
                     answers: ["The Shard", "Восточная башня комплекса Федерация", "Лахта-центр", "Сапфир Стамбула"],
                     correctAnswerIndex: 2
            ),
            Question(question: "В каком году состоялся первый выход человека в открытый космос?",
                     answers: ["1963", "1961", "1962", "1965"],
                     correctAnswerIndex: 3
            ),
            Question(question: "Какой из этих брендов не призводит сноуборды?",
                     answers: ["Rossignol", "Salomon", "Nitro", "ATEMI"],
                     correctAnswerIndex: 3
            ),
            Question(question: "В каком году была начата разработка текущего варианта языка программирования Swift?",
                     answers: ["2014", "2010", "1989", "2015"],
                     correctAnswerIndex: 1
            ),
        ]
        
        let questionsCaretaker = QuestionsCaretaker()
        
        if let userQuestions = questionsCaretaker.load() {
            userQuestions.map { questions.append($0) }
        }
        return questions
    }
}

