//
//  GameDataDelegate.swift
//  millionaireGame
//
//  Created by Vasiliy Kapyshkov on 13.06.2021.
//

import Foundation

protocol GameDataDelegate: AnyObject {
    func increaseCorrectAnswer()
    func getReward() -> Int
    func stopByUser()
    func saveResult()
}
