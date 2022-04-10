//
//  Letterfy.swift
//  Wordle
//
//  Created by Songjoon Baek on 3/10/22.
//

import Foundation

import SwiftUI

struct Letterfy: AnimatableModifier {
    
    init (_ status: LetterType) {
        rotation = (status == LetterType.NOTCHECKED) ? 0 : 180
        fillColor = (status == LetterType.NOTCHECKED) ? Color.QuaternaryColor :
            ((status == LetterType.IN) ? Color.SecondaryColor :
                ((status == LetterType.CORRECT) ? Color.PrimaryColor : Color.TertiaryColor))
    }
    
    var animatableData: Double {
        get { rotation }
        set { rotation = newValue }
    }
    
    var rotation : Double  // in degrees
    var fillColor: Color
    
    func body(content: Content) -> some View {
        ZStack {
            let shape = Rectangle()
        //    content
            //    .opacity((rotation < 90) ? 0.5 : 1)
            if rotation < 90 {
                shape.fill()
                    .foregroundColor(Color("Border Color"))
                shape.strokeBorder(lineWidth: 1.0)
                content
                    .rotation3DEffect(Angle.degrees(0), axis: /*@START_MENU_TOKEN@*/(x: 0.0, y: 1.0, z: 0.0)/*@END_MENU_TOKEN@*/)
            } else {
                shape.fill()
                    .foregroundColor(fillColor)
                shape.strokeBorder(lineWidth: 2.0)
                content
                    .rotation3DEffect(Angle.degrees(180), axis: /*@START_MENU_TOKEN@*/(x: 0.0, y: 1.0, z: 0.0)/*@END_MENU_TOKEN@*/)
            }
        }.rotation3DEffect(Angle.degrees(rotation), axis: /*@START_MENU_TOKEN@*/(x: 0.0, y: 1.0, z: 0.0)/*@END_MENU_TOKEN@*/)
    }
}
  
extension View {
    func letterfy(type: LetterType) -> some View {
        return self.modifier(Letterfy(type))
    }
}
