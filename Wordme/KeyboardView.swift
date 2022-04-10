//
//  KeyboardView.swift
//  Wordle
//
//  Created by Songjoon Baek on 3/1/22.
//

import SwiftUI


struct KeyView: View {
    
    var letter: String
    var status: LetterType
    var height: CGFloat
    var width: CGFloat
    @Binding var tapped : String
    
    var body: some View {
        GeometryReader { geometry in
            self.body(for: geometry.size)
        }
    }
    
    private func body(for size: CGSize) -> some View {
        ZStack {
            let inc:CGFloat = (tapped == letter) ? -2.0 : 0.0
            RoundedRectangle(cornerRadius: 3.0).fill(Color.gray)
                .offset(x: -2.0, y: -2.0)
            Group {
                RoundedRectangle(cornerRadius: 3.0).fill((status == LetterType.NOTCHECKED) ? Color.QuaternaryColor :
                                                            (status == LetterType.NOTIN) ? Color.TertiaryColor :
                                                            (status == LetterType.IN) ? Color.SecondaryColor :
                                                            (status == LetterType.CORRECT) ? Color.PrimaryColor : Color.BackgroundColor)
                             
                RoundedRectangle(cornerRadius: 3.0).stroke(lineWidth: 1)
                Text(letter)
                    .font(Font.system(size: fontSize(for: size)))
            }.offset(x: inc, y: inc)
        }
        .frame(width: width, height: height, alignment: .center)

    }
    
    func fontSize(for size: CGSize) -> CGFloat {
        min(size.width, size.height) * 0.8 / CGFloat(letter.count > 1 ? 1.5 : 1)
    }
        
}

struct KeyboardView: View {
   
    @ObservedObject var viewModel:WordmeGame
    @State var tapped : String = ""

    func addKeys(_ keys: [String]) -> some View {
        Group {
            ForEach(keys, id:\.self) { key in
                KeyView(letter: key, status:viewModel.status[key]!,height: keysize, width: keysize,tapped: $tapped)
                    .onTapGesture {
                        print("KeyboardView: tapGesture")
                        tapped = key
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                            tapped = ""
                        }
                        viewModel.guess(alphabet: Character(key))
                    }
                    .help(key)
            }
        }
    }
    
    var body: some View {
        VStack {
                HStack{
                    addKeys(["Q","W","E","R","T","Y","U","I","O","P"])
                }.frame(minHeight:keysize, idealHeight: keysize, maxHeight: keysize, alignment: .center)
                HStack{
                    Spacer()
                        .frame(width: keysize * 0.5)
                    addKeys(["A","S","D","F","G","H","J","K","L"])
                    Spacer()
                        .frame(width: keysize * 0.5)
                }.frame(minHeight:keysize, idealHeight: keysize, maxHeight: keysize, alignment: .center)
                HStack{
                    Group {
                        //KeyView("Enter", .NOTCHECKED, keysize*2, keysize).frame(width: keysize*2, height: keysize)
                        KeyView(letter: "Enter",status: .NOTCHECKED, height: keysize, width: keysize*1.5 , tapped: $tapped)
                            .onTapGesture {
                                viewModel.score()
                            }.frame(width: keysize * 1.5, height: keysize, alignment: .center)
                        addKeys(["Z","X","C","V","B","N","M"])
                        KeyView(letter: "🔙", status:.NOTCHECKED, height: keysize, width: keysize*2 , tapped: $tapped)
                            .onTapGesture {
                                viewModel.del()
                            }
                            .frame(width: keysize * 1.5, height: keysize, alignment: .center)
                    }
               }.frame(minHeight:keysize, idealHeight: keysize, maxHeight: keysize, alignment: .center)
        }
    }
    private let keysize : CGFloat = 25
    
}

struct KeyboardView_Previews: PreviewProvider {
    static var previews: some View {
        KeyboardView(viewModel:WordmeGame())
    }
}
