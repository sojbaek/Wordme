//
//  UserDefaultsUtils.swift
//  Wordle
//
//  Created by Songjoon Baek on 3/14/22.
//

import Foundation

class UserDefaultsUtils {
static var shared = UserDefaultsUtils()
 func setDarkMode(enable: Bool) {
   let defaults = UserDefaults.standard
   defaults.set(enable, forKey: Constants.DARK_MODE)
 }
 func getDarkMode() -> Bool {
  let defaults = UserDefaults.standard
  return defaults.bool(forKey: Constants.DARK_MODE)
 }
    
  func setHCMode(enable: Bool) {
      let defaults = UserDefaults.standard
      defaults.set(enable, forKey: Constants.HIGHCONTRAST_MODE)
    }
   func getHCMode() -> Bool {
     let defaults = UserDefaults.standard
     return defaults.bool(forKey: Constants.HIGHCONTRAST_MODE)
   }
}
