//
//  UIStoryboard++.swift
//  StarSEexam
//
//  Created by Toe Wai Aung on 01/07/2024.
//

import UIKit
import Foundation

extension UIStoryboard {
    
    static var Main = UIStoryboard(name: "Main", bundle: nil)
    
    func instantitate<T: UIViewController>(_ type: T.Type) -> T {
        return self.instantiateViewController(withIdentifier: String(describing: T.self)) as! T
    }
    
    enum StoryBoard: String {
        case main = "Main"
        case tutorial = "Tutorial"
        case home = "Home"
        case Intro = "Intro"
        
        func instance(_ vc:String) -> UIViewController {
            return UIStoryboard(name: self.rawValue, bundle: Bundle.main).instantiateViewController(withIdentifier: vc)
        }
    }
    
    class func Intro() -> UIViewController {
        return StoryBoard.Intro.instance(IntroVC.className) as! IntroVC
    }
//    class func HelpSupport() -> UIViewController {
//        return StoryBoard.popUp.instance(HelpSupportVC.className) as! HelpSupportVC
//    }
//
//
//    class func PopUpSuccess() -> UIViewController {
//        return StoryBoard.popUp.instance(PopUpSuccessVC.className) as! PopUpSuccessVC
//    }
//
//    class func PopUpFeedback() -> UIViewController {
//        return StoryBoard.popUp.instance(PopUpFeedbackVC.className) as! PopUpFeedbackVC
//    }
//
//    class func PopUpDialogue() -> UIViewController {
//        return StoryBoard.popUp.instance(PopUpDialogueVC.className) as! PopUpDialogueVC
//    }
    
}

extension NSObject {
    var className: String {
        return String(describing: type(of: self))
    }
    
    class var className: String {
        return String(describing: self)
    }
}

