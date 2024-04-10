//
//  BaseViewController.swift
//  secret_santa
//
//  Created by Mariya Aliyeva on 10.04.2024.
//

import UIKit

class BaseViewController: UIViewController {
	
	// MARK: - Lifecycle
	override func viewDidLoad() {
		super.viewDidLoad()
	
		addLanguageObserver()
	}
	
	func setupTitles() { }
		
	// MARK: - Observer
	
	private func addLanguageObserver() {
		NotificationCenter.default.addObserver(
			self,
			selector: #selector(reloadTitles),
			name: NSNotification.Name("language"),
			object: nil
		)
	}
	
	@objc
	private func reloadTitles() {
		setupTitles()
	}
}

