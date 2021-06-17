//
//  GameResultTableViewCell.swift
//  millionaireGame
//
//  Created by Vasiliy Kapyshkov on 14.06.2021.
//

import UIKit

class GameResultTableViewCell: UITableViewCell {

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var answersLabel: UILabel!
    @IBOutlet weak var rewardLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }

    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    
    func configure(with result: GameResult) {
        let df = DateFormatter()
        df.locale = Locale(identifier: "ru_RU")
        df.dateFormat = "d.MM.yyyy H:mm:ss"
        dateLabel.text = df.string(from: result.date)
        answersLabel.text = "Ответов: \(result.correctAnswers)"
        rewardLabel.text = Game.shared.numberFormatter.string(from: NSNumber(value: result.reward))
    }
}
