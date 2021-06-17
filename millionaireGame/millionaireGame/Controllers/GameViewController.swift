//
//  GameViewController.swift
//  millionaireGame
//
//  Created by Vasiliy Kapyshkov on 13.06.2021.
//

import UIKit

class GameViewController: UIViewController {

    @IBOutlet weak var cerrectAnswersLabel: UILabel!
    @IBOutlet weak var helpByCallBtn: UIButton!
    @IBOutlet weak var helpBySpectatorsBtn: UIButton!
    @IBOutlet weak var helpBy50Btn: UIButton!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var answerBtnA: UIButton!
    @IBOutlet weak var answerBtnB: UIButton!
    @IBOutlet weak var answerBtnC: UIButton!
    @IBOutlet weak var answerBtnD: UIButton!
    
    weak var gameDataDelegate: GameDataDelegate?
    
    private var answerButtons: [UIButton] = []
    private var currentQuestionIndex: Int = 0
    private var correctAnswer: String = ""
    var difficultyStrategy: DifficultyStrategyProtocol?
    var questions: [Question] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        difficultyStrategy?.questionsOrder(questions: &questions)
        answerButtons = [answerBtnA, answerBtnB, answerBtnC, answerBtnD]
        buttonsConf()
        setScene()
        
        Game.shared.session?.correctAnswers.addObserver(self, options: [.new, .initial], closure: { [weak self] (count, _) in
            guard let self = self else { return }
            self.cerrectAnswersLabel.text = "Правильных ответов: \(count) из \(Game.shared.session!.totalQuestions)"
        })

    }
    
    
    private func buttonsConf() {
        for button in answerButtons {
            button.layer.borderWidth = 2
            button.layer.borderColor = CGColor(red: 0.178, green: 0.376, blue: 0.855, alpha: 1)
            button.titleLabel?.lineBreakMode = .byWordWrapping
            button.titleLabel?.textAlignment = .center
        }
    }
    
    
    private func setScene() {
        let questionItem = questions[currentQuestionIndex]
        
        correctAnswer = questionItem.answers[questionItem.correctAnswerIndex]
        questionLabel.text = questionItem.question
        
        for (i, button) in self.answerButtons.enumerated() {
            button.setTitle(questionItem.answers[i], for: .normal)
            button.removeTarget(nil, action: nil, for: .touchUpInside)
            
            let targetSelector = questionItem.correctAnswerIndex == i ? #selector(self.correctAnswerHandle) : #selector(self.wrongAnswerHandle)
            button.addTarget(self, action: targetSelector, for: .touchUpInside)
            button.isHidden = false
        }
        
    }
    
    
    @objc func wrongAnswerHandle(sender: UIButton) {
        let questionItem = questions[currentQuestionIndex]
        let correctButton = answerButtons[questionItem.correctAnswerIndex]
        
        correctButton.layer.backgroundColor = CGColor(red: 0.340, green: 0.516, blue: 0.230, alpha: 1)
        sender.layer.backgroundColor = CGColor(red: 0.772, green: 0.213, blue: 0.153, alpha: 1)
        
        gameDataDelegate?.saveResult()
        showAnswerAlert(title: "Ой!", text: "К сожалению, это неправильный ответ", buttonText: "Закончить игру")
    }
    
    
    @objc func correctAnswerHandle(sender: UIButton) {
        gameDataDelegate?.increaseCorrectAnswer()
        
        if questions.indices.contains(currentQuestionIndex+1) {
            currentQuestionIndex += 1
            setScene()
        } else {
            gameDataDelegate?.saveResult()
            showAnswerAlert(title: "Поздравляем!", text: "Вы ответили правильно на все вопросы и выиграли свой виртуальный миллион!", buttonText: "Ура!")
        }
    }
    
    
    private func showAnswerAlert(title: String, text: String, buttonText: String) {
        let alert = UIAlertController(title: title, message: text, preferredStyle: .alert)
        let action = UIAlertAction(title: buttonText, style: .default) { _ in
            self.dismiss(animated: true, completion: nil)
        }
        alert.addAction(action)
        
        DispatchQueue.main.async {
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    
    private func showHintAlert(title: String, text: String) {
        let alert = UIAlertController(title: "", message: "", preferredStyle: .actionSheet)
        
        let titleString = NSAttributedString(string: title,
                                             attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 20)])
        let msgString = NSAttributedString(string: text,
                                           attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17)])
        let closeAction = UIAlertAction(title: "Спасибо!", style: .cancel)
        
        alert.setValue(titleString, forKey: "attributedTitle")
        alert.setValue(msgString, forKey: "attributedMessage")
        alert.addAction(closeAction)
        
        DispatchQueue.main.async {
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    
    @IBAction func hintCall(_ sender: UIButton) {
        sender.isEnabled = false
        showHintAlert(title: "Звонок другу", text: "Ваш друг подсказывает, что скорее всего правильный ответ – \(correctAnswer)")
    }
    
    
    @IBAction func hintSpectators(_ sender: UIButton) {
        sender.isEnabled = false
        showHintAlert(title: "Помощь зала", text: "Большинство зрителей считает, что правильный ответ – \(correctAnswer)")
    }
    
    
    @IBAction func hintFiftyFifty(_ sender: UIButton) {
        sender.isEnabled = false
        var excludeIndexes: [Int] = []
        let questionItem = questions[currentQuestionIndex]
        
        while excludeIndexes.count < 2 {
            let start = questionItem.correctAnswerIndex == 0 ? 1 : 0
            let end = questionItem.correctAnswerIndex == 3 ? 2 : 3
            let i = Int.random(in: start...end)
            if i != questionItem.correctAnswerIndex && !excludeIndexes.contains(i) {
                excludeIndexes.append(i)
                answerButtons[i].isHidden = true
            }
        }
    }
    
    
    @IBAction func exitAction(_ sender: UIButton) {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let continueAction = UIAlertAction(title: "Продолжить играть", style: .cancel)
        let exitAction = UIAlertAction(title: "Завершить игру", style: .default, handler: { _ in
            self.gameDataDelegate?.stopByUser()
            self.gameDataDelegate?.saveResult()
            self.dismiss(animated: true, completion: nil)
        })
        
        if currentQuestionIndex > 0, let reward = gameDataDelegate?.getReward() {
            let formattedReward = Game.shared.numberFormatter.string(from: NSNumber(value: reward))
            let msgString = NSAttributedString(string: "Завершить игру и забрать выигрыш \(formattedReward!)?",
                                               attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17)])
            alert.setValue(msgString, forKey: "attributedMessage")
        }
        
        alert.addAction(continueAction)
        alert.addAction(exitAction)
        
        DispatchQueue.main.async {
            self.present(alert, animated: true, completion: nil)
        }
    }
}
