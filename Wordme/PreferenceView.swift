//
//  PreferenceView.swift
//  Wordle
//
//  Created by Baek, Songjoon (NIH/NCI) [E] on 3/11/22.
//


import SwiftUI


struct SettingsView: View {
    
    
    @State private var hardmode = false
    @State private var darkmode = false
    @State private var highcontmode = false

    var body: some View {
        NavigationView {
            Form {
                Toggle("Hard Mode", isOn: $hardmode)
                Toggle("Dark Mode", isOn: $darkmode)
                Toggle("High Contrast Mode", isOn: $highcontmode)
                HStack{
                    Text("Feedback")
                    Spacer()
                    Link("Email", destination: URL(string: "https://www.mylink.com")!)
                }

                HStack{
                    Text("Community")
                    Spacer()
                    Link("Twitter", destination: URL(string: "https://www.mylink.com")!)
                }
               
                HStack{
                    Text("Questions?")
                    Spacer()
                    Link("FAQ", destination: URL(string: "https://www.mylink.com")!)
                }
            }.navigationBarTitle("SETTINGS")
        }
    }
}

struct PreferenceView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}

