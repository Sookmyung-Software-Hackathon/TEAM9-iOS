//
//  RootChange.swift
//  Farmily
//
//  Created by 김혜수 on 2022/08/28.
//

import UIKit
import RxSwift

final class RootChange {
    enum Destination {
        case initial
        case mainTab
    }
    
    static let shared = RootChange()
    
    func update(_ destination: Destination) {
        let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate
        guard let delegate = sceneDelegate else {
            return
        }
        switch destination {
        case .initial:
            delegate.window?.rootViewController = UIStoryboard(name: Const.Storyboard.Initial, bundle: nil)
                .instantiateViewController(withIdentifier: Const.ViewController.InitialViewController)
        case .mainTab:
            delegate.window?.rootViewController = UIStoryboard(name: Const.Storyboard.Main, bundle: nil)
                .instantiateViewController(withIdentifier: Const.ViewController.MainTabBarController)
        }
    }
}
