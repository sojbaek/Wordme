//
//  HowToPlay.swift
//  Wordle
//
//  Created by Songjoon Baek on 3/5/22.
//

import SwiftUI


struct HowToPlay: View {
    
    @State private var letterW = WordmeLetter(status: LetterType.NOTCHECKED, letter: "W")
    @State private var letterI = WordmeLetter(status: LetterType.NOTCHECKED, letter: "I")
    @State private var letterU = WordmeLetter(status: LetterType.NOTCHECKED, letter: "U")
    
    var body: some View {
        VStack {
            Text("HOW TO PLAY")
                .bold()
                .font(.title)
            Text("")
            ScrollView {
                VStack(alignment: .leading){
                    Group {
                        VStack(alignment: .leading, spacing: 10) {
                            HStack(spacing: 5) {
                                Text("Guess the").font(.footnote)
                                Text("WORDME").bold().font(.footnote)
                                Text("in six tries.").font(.footnote)
                            }
                            Text("Each guess must be a valid five-letter word. Hit the enter button to submit.")
                                .font(.footnote)
                            Text("After each guess, the color of the titles will change to show how close your guess was to the word.").font(.footnote)
                        }.fixedSize(horizontal: false, vertical: true)
                        
                        Divider()
                        
                        Group{
                            Text("Examples").bold()
                            
                            HStack(alignment:.center, spacing: 2) {
                                LetterView(letterW)
                                LetterView(WordmeLetter(status: LetterType.NOTCHECKED, letter: "E"))
                                LetterView(WordmeLetter(status: LetterType.NOTCHECKED, letter: "A"))
                                LetterView(WordmeLetter(status: LetterType.NOTCHECKED, letter: "R"))
                                LetterView(WordmeLetter(status: LetterType.NOTCHECKED, letter: "Y"))
                            }
                            .onAppear() {
                                withAnimation(Animation.easeInOut(duration: 1).delay(0.5)){
                                    letterW.status = LetterType.CORRECT
                                }
                            }
                            .frame(minHeight:50)
                            
                            Text("The letter W is in the word and in the correct spot.").font(.footnote)
                            
                            HStack(alignment:.center, spacing: 2) {
                                LetterView(WordmeLetter(status: LetterType.NOTCHECKED, letter: "P"))
                                LetterView(letterI)
                                LetterView(WordmeLetter(status: LetterType.NOTCHECKED, letter: "L"))
                                LetterView(WordmeLetter(status: LetterType.NOTCHECKED, letter: "L"))
                                LetterView(WordmeLetter(status: LetterType.NOTCHECKED, letter: "S"))
                            }
                            .onAppear() {
                                withAnimation(Animation.easeInOut(duration: 1).delay(1.5)){
                                    letterI.status = LetterType.IN
                                }
                            }
                            .frame(minHeight:50)
                            
                            Text("The letter I is in the word but in the wrong spot.").font(.footnote)
                            Text("")
                            HStack(alignment:.center, spacing: 2) {
                                LetterView(WordmeLetter(status: LetterType.NOTCHECKED, letter: "V"))
                                LetterView(WordmeLetter(status: LetterType.NOTCHECKED, letter: "A"))
                                LetterView(WordmeLetter(status: LetterType.NOTCHECKED, letter: "G"))
                                LetterView(letterU)
                                LetterView(WordmeLetter(status: LetterType.NOTCHECKED, letter: "E"))
                            }
                            .frame(minHeight:50)
                            .onAppear() {
                                withAnimation(Animation.easeInOut(duration: 1).delay(2.5)){
                                    letterU.status = LetterType.NOTIN
                                }
                            }

                            Text("The letter U is not in the word in any spot.") .font(.footnote)
                        }
                        Divider()
                    }

                }
            }
            
        }.padding()
    }
}

struct HowToPlay_Previews: PreviewProvider {
    static var previews: some View {
        HowToPlay()
    }
}
