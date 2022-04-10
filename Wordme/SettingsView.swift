//
//  PreferenceView.swift
//  Wordle
//
//  Created by Songjoon Baek on 3/11/22.
//


import SwiftUI


struct SettingsView: View {
    
    @Binding var settings: Settings
    @Environment(\.colorScheme) private var colorScheme: ColorScheme
    @Environment(\.colorSchemeContrast) private var colorSchemeContrast: ColorSchemeContrast
    @State private var isDarkModeOn = false
    @State private var isHCModeOn = false
    
    
    var body: some View {
        NavigationView {
            Form {
                Toggle("Hard Mode", isOn: $settings.hardMode)
                    .accentColor(Color.PrimaryColor)
                Toggle("Dark Mode", isOn: $isDarkModeOn)
                    .accentColor(Color.SecondaryColor)
                    .onChange(of: isDarkModeOn) { value in
                        changeDarkMode(state: value)
                    }
                
                Toggle("High Contrast Mode", isOn: $isHCModeOn)
                    .accentColor(Color.TertiaryColor)
                    .onChange(of: isHCModeOn) { value in
                        changeHCMode(state: value)
                    }
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
            .onAppear {
                setAppTheme()
            }
        }.background(Color.BackgroundColor)
    }
    
    func setAppTheme() {
        //MARK: use saved device theme from toggle
        isDarkModeOn = UserDefaultsUtils.shared.getDarkMode()
        isHCModeOn = UserDefaultsUtils.shared.getHCMode()
        changeDarkMode(state: isDarkModeOn)
        changeHCMode(state: isHCModeOn)
        //MARK: or use device theme
        
        isDarkModeOn =  (colorScheme == .dark)
        isHCModeOn =  (colorSchemeContrast == .increased)
        changeDarkMode(state: isDarkModeOn)
        changeHCMode(state: isHCModeOn)
    }
    
    func changeDarkMode(state: Bool) {
        
        (UIApplication.shared.connectedScenes.first as?
          UIWindowScene)?.windows.first!.overrideUserInterfaceStyle = state ?   .dark : .light
          UserDefaultsUtils.shared.setDarkMode(enable: state)
    }
    func changeHCMode(state: Bool) {
//        (UIApplication.shared.connectedScenes.first as?
//            UIWindowScene)?.windows.first!.overrideUserInterfaceStyle =   .standard : .increased
      //  (UIApplication.shared.connectedScenes.first as? UIWindowScene)?.windows.
      //  UIScreen.main.traitCollection.accessibilityContrast = state ? UIAccessibilityContrast.high :  UIAccessibilityContrast.normal
        (UIApplication.shared.connectedScenes.first as?
                UIWindowScene)?.windows.first!.overrideUserInterfaceStyle = state ?   .dark : .light
       // UIAccessibilityContrast
        
        
        
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(settings: .constant(Settings()))
    }
}

