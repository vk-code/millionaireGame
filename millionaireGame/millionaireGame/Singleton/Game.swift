//
//  Game.swift
//  millionaireGame
//
//  Created by Vasiliy Kapyshkov on 13.06.2021.
//

import Foundation

class Game {
    
    public static var shared = Game()
    var session: GameSession?
    var numberFormatter: NumberFormatter = {
        let nf = NumberFormatter()
        nf.locale = Locale(identifier: "ru_RU")
        nf.numberStyle = .currency
        nf.usesGroupingSeparator = true
        nf.maximumFractionDigits = 0
        return nf
    }()
    
    private init() { }
}
