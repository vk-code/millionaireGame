//
//  NewQuestionTableViewCell.swift
//  millionaireGame
//
//  Created by Vasiliy Kapyshkov on 17.06.2021.
//

import UIKit

class NewQuestionTableViewCell: UITableViewCell {

    @IBOutlet weak var questionInput: UITextField!
    @IBOutlet weak var answerInput1: UITextField!
    @IBOutlet weak var answerInput2: UITextField!
    @IBOutlet weak var answerInput3: UITextField!
    @IBOutlet weak var answerInput4: UITextField!
    @IBOutlet weak var answerSwitcher1: UISwitch!
    @IBOutlet weak var answerSwitcher2: UISwitch!
    @IBOutlet weak var answerSwitcher3: UISwitch!
    @IBOutlet weak var answerSwitcher4: UISwitch!
    
    private var switchers: [UISwitch] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func conf() {
        
        switchers = [answerSwitcher1, answerSwitcher2, answerSwitcher3, answerSwitcher4]
        
        for switcher in switchers {
            switcher.isEnabled = true
            switcher.isSelected = false
            switcher.addTarget(self, action: #selector(toggleCorrectAnswer), for: .allEvents)
        }
        
        questionInput.text = ""
        answerInput1.text = ""
        answerInput2.text = ""
        answerInput3.text = ""
        answerInput4.text = ""
    }
    
    
    @objc private func toggleCorrectAnswer(_ sender: UISwitch) {
        let state = sender.isOn
        
        for switcher in self.switchers {
            if switcher != sender {
                switcher.isEnabled = !state
            }
        }
    }
}
