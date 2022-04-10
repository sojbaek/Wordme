//
//  StatisticsModel.swift
//  Wordle
//
//  Created by Songjoon Baek on 3/4/22.
//

import Foundation
import SwiftUI

struct Statistics: Hashable, Codable {
    var played: Int
    var winPercent: Int
    var currentStreak: Int
    var maxStreak : Int
    var guessDist: [Int]       // 1 for 1st, 2 for 2nd, ...
    var lastNumGuess : Int     // if  <= 0, game not played
    
    init() {
        played = 29
        winPercent = 90
        currentStreak = 2
        maxStreak = 7
        guessDist = [0, 0,0,2,7,12,5]
        lastNumGuess = 4
    }
}
