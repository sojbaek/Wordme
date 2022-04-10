//
//  Cardify.swift
//  Wordle
//
//  Created by Songjoon Baek on 2/28/22.
//

import SwiftUI

extension View {
    func cardify(_ status: LetterType = LetterType.NOTCHECKED) -> some View {
        self.modifier(Cardify(status))
    }
}

struct Cardify : AnimatableModifier {
    
    var status: LetterType
    var rotation: Double
    
    init(_ status: LetterType) {
        self.status = status
        rotation = 0
    }
    
    var animatableData: Double {
        get { return rotation }
        set { rotation = newValue}
    }
    
    func body(content: Content) -> some View {
        ZStack {
                Group {
                    Rectangle().fill((self.status == LetterType.NOTCHECKED) ? Color.white :
                                        (self.status == LetterType.NOTIN) ? Color.gray :
                                        (self.status == LetterType.IN) ? Color.yellow :
                                        (self.status == LetterType.CORRECT) ? Color.green : Color.black)
                                     
                    Rectangle().stroke(lineWidth: edgeLineWidth)
                    content
                }
                .rotationEffect(Angle.degrees(rotation))
        }
    }
    
    private let edgeLineWidth : CGFloat = 1
}
