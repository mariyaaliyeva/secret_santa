//
//  MainTabBarViewController.swift
//  secret_santa
//
//  Created by Mariya Aliyeva on 06.04.2024.
//

import UIKit

final class MainTabBarViewController: UITabBarController {

	// MARK: - Private properties
	
	private let icons: [UIImage?] = [
		UIImage(named: "home_icon"),
		UIImage(named: "present_icon"),
		UIImage(named: "profile_icon")
	]
	
	private let selectedIcons: [UIImage?] = [
		UIImage(named: "orange_home_icon"),
		UIImage(named: "orange_present_icon"),
		UIImage(named: "orange_profile_icon")
	]
	
	private var allViewController = [
		UINavigationController(rootViewController: HomeViewController()),
		UINavigationController(rootViewController: PresentViewController()),
		UINavigationController(rootViewController: ProfileViewController())
	]
	
	// MARK: - Lifecycle
	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = .cyan
		makeTabBarViews()
	}
	
	// MARK: - Private methods
	private func makeTabBarViews() {
		
		setViewControllers(allViewController, animated: false)
		
		guard let items = self.tabBar.items else {return}
		
		for i in 0..<items.count {
			items[i].image = icons[i]?.withBaselineOffset(fromBottom: 30)
			items[i].selectedImage = selectedIcons[i]?.withBaselineOffset(fromBottom: 30)
		}
		
		let tabbarAppearance = UITabBarAppearance()
		tabbarAppearance.configureWithOpaqueBackground()
		tabbarAppearance.backgroundColor = .white

		tabBar.standardAppearance = tabbarAppearance
		tabBar.scrollEdgeAppearance = tabbarAppearance

	}
}

