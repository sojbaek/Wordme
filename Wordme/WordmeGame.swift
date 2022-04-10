//
//  WordleGame.swift
//  Wordle
//
//  Created by Songjoon Baek on 3/3/22.
//

import SwiftUI

class WordmeGame : ObservableObject {
    
    @Published private var model: WordmeModel = WordmeGame.createWordmeGame()
    @Published private var stat: Statistics = Statistics()
    
    @Published var wordmeError : WordmeError = WordmeError.NOERROR
        
    private static func createWordmeGame() -> WordmeModel {
        return WordmeModel()
    }

    private func scoringAnimation(col: Int) -> Animation {
        let delay = Double(col) * (WordmeGameConstants.scoringDuration / 5.0)
        return Animation.easeInOut(duration: WordmeGameConstants.scoringDuration / 5.0).delay(delay)
    }
    
    private struct WordmeGameConstants {
        static let scoringDuration: Double = 2
    }
    
    // MARK: - Access to the model
    var guesses:  Array <Array <WordmeLetter> >{
        model.guesses
    }
    
    var status :  [String : LetterType] {
        model.status
    }
    
    var trial : Int {
        model.trial
    }
    
    var settings : Settings {
        get {
            model.settings
        }
        
        set {
            model.settings = newValue
        }
    }
    
    // MARK: - Intent(s)
    
    func guess(alphabet: Character) {
        model.guess(alphabet: alphabet)
    }
    
    func del() {
        model.del()
    }
    
    func score() {
        if  wordmeError == WordmeError.NOERROR   {
            let result = model.score()
            for ii in 0...4 {
                withAnimation(scoringAnimation(col: ii)) {
                    model.update(col: ii)
                }
            }
            if result {
                model.next()
            }
            wordmeError = model.wordleError
            if wordmeError != WordmeError.NOERROR {
                Timer.scheduledTimer(withTimeInterval: 2.0, repeats: false, block:{ _ in
                    self.snooze()
                }  )
            }
        }
    }
    
    func snooze() {
        wordmeError = WordmeError.NOERROR
        model.snooze()
    }
    
    func statistics() -> Statistics{
        stat
    }
}

