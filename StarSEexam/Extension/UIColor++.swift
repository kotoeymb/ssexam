//
//  UIColor++.swift
//  StarSEexam
//
//  Created by Toe Wai Aung on 01/07/2024.
//

import UIKit

extension UIColor {
    
    static let primary = UIColor(hex: "EEB61D")
    static let primaryAlpha = UIColor(hex: "FAF8F1")
    static let primarySuper = UIColor(hex: "FFC48C")

    static let secondary = UIColor(hex: "636363")
    static let secondaryAlpha = UIColor(hex: "ABABAB")
    static let secondarySuper = UIColor(hex: "000000")
    
    
    convenience init(hex:String) {
        var cString: String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
    
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }

        var rgbValue: UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)
    
        self.init(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
}

enum SayaColor: String {
    case Cyan = "68ced9"
    case DarkCyan = "48B5C0"
    case FlatCyan = "82CCD7"
    case Gray = "efefef"
    case Red = "E25845"
    case Green = "68BF8F"
    case Magenta = "2c1242"
    case FlatPurple = "5357bc"
    case DarkGrey = "5D5172"
    case FlatOrange = "F7C016"
    case FlatRed = "D93829"
    case FlatMilk = "F2F2F3"
    case HCBlack = "263238"
    case disableColor = "f6f6f6"
    case FontColor = "000a12"
    case pendingColor = "ed1c24"
    case processingColor = "ffd200"
    case acceptedColor = "197b30"
    case bgRed = "FF0000"
    case ccccccc = "CCCCCC"
    case loadingColor = "C0C0C0"
    case questionUnchooseBg = "A82B42"
    case questionBg = "E2365B"
    case questionChooseWrong = "FC3F49"
    case genderGreen = "34C759"
    case genderGray = "BBBBBB"
    case buttonGreen = "22B561"
    

    func instance() -> UIColor {
        return UIColor(hex: self.rawValue)
    }
    
    //MARK:- Usage: Saya Color -> SayaColor.Cyan.instance()
}

