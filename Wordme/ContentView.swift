//
//  ContentView.swift
//  Wordle
//
//  Created by Baek, Songjoon (NIH/NCI) [E] on 2/28/22.
//

import SwiftUI

struct WordmeView: View {
    var model: WordmeModel
    
    var body: some View {
        
        KeyboardView(model:model)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        WordmeView(model: WordmeModel())
    }
}
