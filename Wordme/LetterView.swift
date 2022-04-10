//
//  LetterView.swift
//  Wordle
//
//  Created by Songjoon Baek on 2/28/22.
//

import SwiftUI

struct LetterView: View {
    
    var wletter: WordmeLetter
    var height: CGFloat
    var width: CGFloat
    
    init(_ wletter: WordmeLetter,_ size:CGFloat = 40) {
        self.wletter = wletter
        self.height = size
        self.width = size
    }

    var body: some View {
        ZStack{
            Text(wletter.letter)
                .font(Font.system(size: height))
        }
        .letterfy(type: wletter.status)
        .frame(width: width, height: height, alignment: .center)
    }
}


struct LetterView_Previews: PreviewProvider {
    static var previews: some View {
        VStack(alignment: .leading, spacing: 15){
            HStack(alignment:.center, spacing: 10){
                LetterView(WordmeLetter(status: LetterType.NOTCHECKED, letter: "A"))
                LetterView(WordmeLetter(status: LetterType.NOTCHECKED, letter: " "))
                LetterView(WordmeLetter(status: LetterType.IN, letter: ""))
                LetterView(WordmeLetter(status: LetterType.CORRECT, letter: "D"))
            }
            HStack(alignment:.center, spacing: 10) {
                LetterView(WordmeLetter(status: LetterType.NOTCHECKED, letter: "A"))
                LetterView(WordmeLetter(status: LetterType.NOTIN, letter: "B"))
                LetterView(WordmeLetter(status: LetterType.IN, letter: "C"))
                LetterView(WordmeLetter(status: LetterType.CORRECT, letter: "D"))
                LetterView(WordmeLetter(status: LetterType.NOTCHECKED, letter: "E"))
            }
            HStack(alignment:.center, spacing: 10) {
                LetterView(WordmeLetter(status: LetterType.NOTCHECKED, letter: "A"))
                LetterView(WordmeLetter(status: LetterType.NOTIN, letter: "B"))
                LetterView(WordmeLetter(status: LetterType.IN, letter: "C"))
                LetterView(WordmeLetter(status: LetterType.CORRECT, letter: "D"))
                LetterView(WordmeLetter(status: LetterType.NOTCHECKED, letter: "E"))
            }
            HStack {
                LetterView(WordmeLetter(status: LetterType.NOTCHECKED, letter: "A"))
                LetterView(WordmeLetter(status: LetterType.NOTIN, letter: "B"))
                LetterView(WordmeLetter(status: LetterType.IN, letter: "C"))
                LetterView(WordmeLetter(status: LetterType.CORRECT, letter: "D"))
                LetterView(WordmeLetter(status: LetterType.NOTCHECKED, letter: "E"))
            }
            HStack {
                LetterView(WordmeLetter(status: LetterType.NOTCHECKED, letter: "A"))
                LetterView(WordmeLetter(status: LetterType.NOTIN, letter: "B"))
                LetterView(WordmeLetter(status: LetterType.IN, letter: "C"))
                LetterView(WordmeLetter(status: LetterType.CORRECT, letter: "D"))
                LetterView(WordmeLetter(status: LetterType.NOTCHECKED, letter: "E"))
            }
            HStack {
                LetterView(WordmeLetter(status: LetterType.NOTCHECKED, letter: "A"))
                LetterView(WordmeLetter(status: LetterType.NOTIN, letter: "B"))
                LetterView(WordmeLetter(status: LetterType.IN, letter: "C"))
                LetterView(WordmeLetter(status: LetterType.CORRECT, letter: "D"))
                LetterView(WordmeLetter(status: LetterType.NOTCHECKED, letter: "E"))
            }
        }
    }
}

