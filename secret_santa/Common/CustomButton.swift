//
//  CustomButton.swift
//  secret_santa
//
//  Created by Mariya Aliyeva on 05.04.2024.
//

import UIKit

class CustomButton: UIButton {
	
	// MARK: - UI
	
	var titleText: String? {
		didSet {
			self.setTitle(titleText, for: .normal)
			self.setTitleColor(.white, for: .normal)
		}
	}
	
	// MARK: - Init
	
	override init(frame: CGRect){
		super.init(frame: frame)
		setupViews()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func layoutSubviews() {
		super.layoutSubviews()
		setup()
	}
	// MARK: - Public
	
	func configure(font: UIFont) {
		self.titleLabel?.font = font
	}
	
	// MARK: - Private
	
	private func setupViews() {
		self.backgroundColor = #colorLiteral(red: 1, green: 0.3882352941, blue: 0, alpha: 1)
	}
	
	private func setup() {
		self.clipsToBounds = true
		self.layer.cornerRadius = 15
	}
}
