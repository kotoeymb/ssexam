//
//  AppCoordinator++.swift
//  StarSEexam
//
//  Created by Toe Wai Aung on 01/07/2024.
//

import UIKit


class AppCoordinator {
    
    static let shared = AppCoordinator()
    
    private init() { initFont() }
    
    private func initFont() {
//        let font = UIFont.TTCommons(.regular, size: 14)
//        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: font], for: .normal)
    }
    
    func coordinate(window: UIWindow?) {
        let startVC : IntroVC = UIStoryboard.Intro() as! IntroVC
        window?.rootViewController = startVC
        window?.makeKeyAndVisible()
    }
    
    func reroute() {
//        let root = isSplashed ? (isAuth ? TabVC().embedInNav() : SignUpVC()) : SplashVC()
//        UIWindow.switchRootView(root)
    }
    
    func restart() {
//        let tab = TabVC().embedInNav()
//        UIWindow.switchRootView(tab)
    }
}

func shared() -> AppDelegate
{
   return UIApplication.shared.delegate as! AppDelegate
}
