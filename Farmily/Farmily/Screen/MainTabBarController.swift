//
//  MainTabBarController.swift
//  Farmily
//
//  Created by 김혜수 on 2022/08/27.
//

import UIKit

class MainTabBarController: UITabBarController {
	
	fileprivate lazy var defaultTabBarHeight = { self.tabBar.frame.size.height }()
	
    override func viewDidLoad() {
        super.viewDidLoad()
		setTabBarUI()
    }
	
	override func viewWillLayoutSubviews() {
		super.viewWillLayoutSubviews()

		let newTabBarHeight = defaultTabBarHeight + 16.0

		var newFrame = self.tabBar.frame
		newFrame.size.height = newTabBarHeight
		newFrame.origin.y = view.frame.size.height - newTabBarHeight

		self.tabBar.frame = newFrame
	}
	
	private func setTabBarUI() {
		self.tabBar.tintColor = UIColor.TabBarGreen
		self.tabBar.backgroundColor = UIColor.white
		self.tabBar.layer.cornerRadius = 12
		self.tabBar.layer.masksToBounds = true
		self.tabBar.layer.borderColor = UIColor.TabBarGreen.cgColor
		self.tabBar.layer.borderWidth = 0.3 //tabbar 테두리 굵기
		self.tabBar.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
	}

}
