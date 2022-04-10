//
//  ContentView.swift
//  Wordle
//
//  Created by Songjoon Baek on 2/28/22.
//

import SwiftUI

struct Shaker: AnimatableModifier {
    
    init (NotFound: Bool) {
        xoffset =  NotFound ? 0 : 10
    }
    var animatableData: CGFloat {
        get { xoffset }
        set { xoffset = newValue }
    }
    
    var xoffset: CGFloat  // in degrees
    
    func body(content: Content) -> some View {
        content
            .offset(x: xoffset)
            .animation(Animation.default.repeatCount(5).speed(4))
    }
   
}


struct Shake: GeometryEffect {
    var amount: CGFloat = 10
    var shakesPerUnit = 3
    var animatableData: CGFloat

    func effectValue(size: CGSize) -> ProjectionTransform {
        ProjectionTransform(CGAffineTransform(translationX:
            amount * sin(animatableData * .pi * CGFloat(shakesPerUnit)),
            y: 0))
    }
}



struct WordmeView: View {
    
    
    //@ObservedObject var viewModel:WordmeGame
    @EnvironmentObject var viewModel:WordmeGame
    @Environment(\.colorScheme) private var colorScheme : ColorScheme
    
    @State private var showingHelp = false
    @State private var showingStat = false
    @State private var showingSettings = false
    @State private var showAlert = false
    @State private var wordleError: WordmeError = WordmeError.NOERROR
    
    @State private var isDarkModeOn = false
    @State private var isHCModeOn = false
        
    @State private var draftSettings = Settings.default
    
    var body: some View {
        VStack{
            GeometryReader { geometry in
                VStack{
                    HStack{
                        Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                            Image(systemName: "text.justify")
                        })
                        Button(action: {
                            showingHelp = true
                        }, label: {
                            Image(systemName: "questionmark.circle")
                        }).popover(isPresented: $showingHelp) {
                            HowToPlay()
                        }
                        Spacer()
                        Text("Word/me").font(.title)
                            .bold()
                        Spacer()
                        Button(action: {
                            showingStat = true
                        }, label: {
                            Image(systemName: "chart.bar.doc.horizontal")
                        }).popover(isPresented: $showingStat) {
                            StatisticsView(stat: viewModel.statistics())
                        }
                        
                        Button(action: {
                            showingSettings = true
                        }, label: {
                            Image(systemName: "gear")
                        }).popover(isPresented: $showingSettings) {
                            SettingsView(settings: $draftSettings)
                                .onAppear {
                                    draftSettings = viewModel.settings
                                }
                                .onDisappear {
                                    viewModel.settings = draftSettings
                                }
                        }
                        
                    }
                    ZStack {  
                        VStack(alignment: .center, spacing: 10){
                            ForEach(0...5, id:\.self) { row in
                                HStack(spacing:5) {
                                    ForEach(0...4, id:\.self) { col in
                                        LetterView(viewModel.guesses[row][col])
                                    }
                                    .modifier(Shake(animatableData: wordleError != WordmeError.NOERROR && row == viewModel.trial ?  10 : 0))
                                    .onChange(of: viewModel.wordmeError) { error in
                                        if error != WordmeError.NOERROR  { // && row == viewModel.trial {
                                            print(".onchange: word not found")
                                            withAnimation() {
                                                wordleError = error                                            }
                                        } else {
                                            wordleError = WordmeError.NOERROR
                                        }
                                    }
                                }.padding(2)
                            }
                        }
                        ZStack{
                            RoundedRectangle(cornerRadius: 10).fill(Color.yellow)
                            switch wordleError {
                            case .NOTINWORDLIST:
                                Text("NOT IN WORD LIST")
                            case .MUSTCONTAIN(let letter):
                                Text("GUESS MUST CONTAIN \(letter)")
                            case .MUSTBE(let pos, let letter):
                                Text("\(pos)st MUST BE \(letter)")
                            default:
                                Text("")
                            }
                        }
                        .frame(height: 50)
                        .opacity(viewModel.wordmeError != WordmeError.NOERROR ? 0.5 : 0.0)
                        .animation(Animation.default.speed(4))
                        
                    }
                    
                    Spacer()
                    KeyboardView(viewModel:viewModel).frame(height:
                                                                keyboardHeight(for: geometry.size)).padding(5)
                }
            }
        }
    }
    func keyboardHeight(for size: CGSize) -> CGFloat {
        size.height * 0.2
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        WordmeView()
            .environmentObject(WordmeGame())
    }
}
