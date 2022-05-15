//
//  WordmeModel.swift
//  Wordle
//
//  Created by Songjoon Baek on 3/1/22.
//

import Foundation

enum LetterType {
    case NOTCHECKED
    case NOTIN
    case IN
    case CORRECT
}

struct WordmeLetter {
    var status: LetterType
    var letter: String
}

extension Notification.Name {
    static let customNotification = Notification.Name.init("wordNotFound")
}

enum WordmeError : Equatable {
    case NOERROR
    case MUSTCONTAIN(letter : String)
    case MUSTBE(pos: Int, letter: String)
    case NOTINWORDLIST
    
    static func == (lhs: WordmeError, rhs: WordmeError) -> Bool {
        switch (lhs, rhs)  {
        case (.NOERROR, .NOERROR):
            return true
        case (.NOTINWORDLIST, .NOTINWORDLIST):
            return true
        case (.MUSTCONTAIN(let let1), .MUSTCONTAIN(let let2)):
            return let1 == let2
        case (.MUSTBE(let pos1, let let1), .MUSTBE(let pos2, let let2)):
            return pos1 == pos2 && let1 == let2
        default:
            return false
        }
    }
}
// ref: https://developer.apple.com/documentation/foundation/archives_and_serialization/encoding_and_decoding_custom_types
struct WordmeModel : Codable {
    public var status : [String : LetterType] = [:]
    public var words5 : [String] = []
    public var guesses : Array <Array <WordmeLetter> >
    public var trial : Int = 0
    public var hpos : Int = 0
    public var solution : String
    public var solved : Bool = false
    public var gameover : Bool = false
    public var wordleError : WordmeError  = WordmeError.NOERROR
    public var settings : Settings = Settings.default
    
    private var scoreboard : Array <LetterType> = []
    
    init() {
        for char in "ABCDEFGHIJKLMNOPQRSTUVWXYZ" {
            status[String(char)] = LetterType.NOTCHECKED
        }
        if let path = Bundle.main.path(forResource: "5-letter-words", ofType: "txt") {
          do {
            let contents = try String(contentsOfFile: path, encoding: .utf8)
            self.words5 = contents.split(separator:"\r\n").map { String($0).uppercased() }
          } catch {
            // Handle error here
          }
        }
        trial = 0
        hpos = 0
        guesses = Array(repeating: Array(repeating: WordmeLetter(status: LetterType.NOTCHECKED, letter: " "), count: 5), count: 6)
        scoreboard = Array(repeating: LetterType.NOTCHECKED,count:5 )
        solution = words5.randomElement()!
        solved = false
        gameover = false
    }
    
    init(from decoder:Decoder) throws {
        self.init();
    }
    
    func encode(to encoder: Encoder) throws {
        
    }
    
    var json: Data? {
        return try? JSONEncoder().encode(self)
    }
    
    init?(json: Data?) {
        if json != nil, let newWordmeModel = try?
            JSONDecoder().decode(WordmeModel.self, from: json!) {
                self = newWordmeModel
            let str = String(decoding: newWordmeModel.json!, as: UTF8.self)
            print("\(str)");
        }
        else {
            return nil
        }
    }
    
    mutating func newgame() {
        trial = 0
        hpos = 0
        guesses = Array(repeating: Array(repeating: WordmeLetter(status: LetterType.NOTCHECKED, letter: " "), count: 5), count: 6)
        solution = words5.randomElement()!
        solved = false
        gameover = false
    }
    
    mutating func guess(alphabet: Character) {
        if trial < 6 && hpos < 5 {
            guesses[trial][hpos] = WordmeLetter(status: LetterType.NOTCHECKED, letter: String(alphabet))
            hpos += 1
        }
        print(String(alphabet) + " has been guessed.\n")
    }
    
    mutating func del() {
        if hpos > 0 {
            hpos -= 1
            guesses[trial][hpos] = WordmeLetter(status: LetterType.NOTCHECKED, letter: " ")
        }
    }
    
    mutating func snooze() {
        wordleError = WordmeError.NOERROR
    }
    
    mutating func update(col ii: Int) {
        let oldstat = status[guesses[trial][ii].letter]
        let newstat = scoreboard[ii]
        if oldstat != LetterType.CORRECT {
            status[guesses[trial][ii].letter] = newstat
        }
        guesses[trial][ii].status = newstat
    }
    
    mutating func next() {
        hpos = 0
        scoreboard = Array(repeating: LetterType.NOTCHECKED,count:5 )
        trial += 1
    }
    
    mutating func score() -> Bool {
        let answer = guesses[trial].reduce("", {x, y in x + y.letter })
        var score = 0
        print("hardmode=\(settings.hardMode)\n")
        print("answer="+answer)
        print("solution="+solution)
        if words5.contains(answer) {
            var sol = Array(solution)
            let ans = Array(answer)
            
            if settings.hardMode {
                if trial > 0 {
                    for ii in 0..<5 {
                        if  guesses[trial-1][ii].letter == String(sol[ii]) && sol[ii] != ans[ii] { // Hard mode
                            wordleError = WordmeError.MUSTBE(pos: ii, letter: String(sol[ii]))
                            return false
                        }
                    }
                    for ll in status.filter({ $0.value == LetterType.IN}).keys {
                        if !answer.contains(ll) {
                            wordleError = WordmeError.MUSTCONTAIN(letter: ll)
                            return false
                        }
                    }
                }
            }
             
            for ii in 0..<5 {
                if ans[ii] == sol[ii] {
                    sol[ii] = " "
                    scoreboard[ii] = LetterType.CORRECT
                    score += 2
                }
            }
                                    
            for ii in 0..<5 {
                if sol[ii] != " " {
                    if sol.contains(ans[ii]) {
                        sol[ii] = " "
                        scoreboard[ii] = LetterType.IN
                        score += 1
                    } else {
                        scoreboard[ii] = LetterType.NOTIN
                    }
                }
            }
            
            if score == 10 {
                print("You win!!")
                solved = true
                gameover = true
            }
            hpos = 0
            if trial > 5 {
                print("Game over!!")
            }
            return true
        } else {
            print("Not in word list")
            wordleError = WordmeError.NOTINWORDLIST
        }
        return false
    }
}
