//
//  SettingsModel.swift
//  Wordle
//
//  Created by Songjoon Baek on 3/12/22.
//

import Foundation

struct Settings {
    var hardMode: Bool = false
    var darkTheme: Bool = false
    var highContrastMode: Bool = false
    
    static let `default` = Settings(hardMode: false, darkTheme: false, highContrastMode: false)
}
