//
//  UIColor++.swift
//  StarSEexam
//
//  Created by Toe Wai Aung on 01/07/2024.
//

import UIKit

extension UIColor {

    convenience init(hex:String,alpha: Double) {
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
            alpha: CGFloat(alpha)
        )
    }
    
}

enum StarSEColor: String {
    
    case disableColor = "f6f6f6"
    case FontColor = "000a12"
    case pendingColor = "ed1c24"
    case processingColor = "ffd200"
    case acceptedColor = "197b30"
    case tutorialBlue = "3D68FF"
    case tutorialGray = "ACACAC"
    func instance(_ alpha: Double?) -> UIColor {
        return UIColor(hex: self.rawValue,alpha: alpha ?? 1)
    }
    
    //MARK:- Usage: StarSE Color -> StarSEColor.Cyan.instance()
}

