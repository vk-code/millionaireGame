//
//  QuestionsViewController.swift
//  millionaireGame
//
//  Created by Vasiliy Kapyshkov on 16.06.2021.
//

import UIKit

struct tempQuestion {
    var question: String?
    var answer: [String] = []
    var correctAnswerIndex: Int?
}

class QuestionsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addRowBtn: UIButton!
    
    private var rowsData: [IndexPath:tempQuestion] = [:]
    private var numberOfRows: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "NewQuestionTableViewCell", bundle: nil), forCellReuseIdentifier: "questionRow")
        addRowBtn.isHidden = true
    }
    
    
    @IBAction func addRow(_ sender: Any) {
        numberOfRows += 1
//        tableView.beginUpdates()
//        tableView.insertRows(at: [IndexPath(row: numberOfRows-1, section: 0)], with: .automatic)
//        tableView.endUpdates()
    }
    
    
    @IBAction func saveQuestions(_ sender: Any) {
        let questionBuilder = QuestionBuilder()
        
        for defCell in self.tableView.visibleCells {
            guard let cell = defCell as? NewQuestionTableViewCell else { continue }
            
            questionBuilder.setQuestion(text: cell.questionInput.text)
            questionBuilder.setAnswer(text: cell.answerInput1.text)
            questionBuilder.setAnswer(text: cell.answerInput2.text)
            questionBuilder.setAnswer(text: cell.answerInput3.text)
            questionBuilder.setAnswer(text: cell.answerInput4.text)
            
            if cell.answerSwitcher1.isOn {
                questionBuilder.setCorrectAnswer(text: cell.answerInput1.text)
            }
            if cell.answerSwitcher2.isOn {
                questionBuilder.setCorrectAnswer(text: cell.answerInput2.text)
            }
            if cell.answerSwitcher3.isOn {
                questionBuilder.setCorrectAnswer(text: cell.answerInput3.text)
            }
            if cell.answerSwitcher4.isOn {
                questionBuilder.setCorrectAnswer(text: cell.answerInput4.text)
            }
            
            guard let question = questionBuilder.build() else { return }
            
            let questionsCaretaker = QuestionsCaretaker()
            questionsCaretaker.save(items: [question])
        }
        dismiss(animated: true, completion: nil)
    }
}


extension QuestionsViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return numberOfRows
        return 1
    }
    

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "questionRow", for: indexPath) as? NewQuestionTableViewCell else { return UITableViewCell() }
        
        cell.conf()
        return cell
    }
    
    
}


extension QuestionsViewController: UITableViewDelegate {
    
}
