//
//  SendToEmailViewController.swift
//  secret_santa
//
//  Created by Mariya Aliyeva on 06.04.2024.
//

import UIKit

final class SendToEmailViewController: UIViewController {
	
	// MARK: - UI
	private lazy var titleLabel = {
		let label = UILabel()
		label.textAlignment = .center
		label.font = UIFont(name: "DMSans-Bold", size: 27)
		label.text = "Письмо отправлено"
		return label
	}()
	
	private lazy var santaImageView = {
		let image = UIImageView()
		image.contentMode = .scaleAspectFit
		image.image = UIImage(named: "santa1")
		return image
	}()
	
	private lazy var enterStackView = {
		let stackView = UIStackView()
		stackView.axis = .horizontal
		stackView.spacing = 2
		stackView.distribution = .fillProportionally
		stackView.alignment = .center
		return stackView
	}()
	
	private var enterLabel: UILabel = {
		let label = UILabel()
		label.text = "Письмо отправлено"
		label.font = UIFont(name: "DMSans-Bold", size: 15)
		label.textColor = #colorLiteral(red: 1, green: 0.3882352941, blue: 0, alpha: 1)
		return label
	}()
	
	private lazy var enterButton: UIButton = {
		let button = UIButton(type: .system)
		let attributes: [NSAttributedString.Key: Any] = [
			.font: UIFont(name: "DMSans-Bold", size: 15) ?? .systemFont(ofSize: 15),
				.foregroundColor: #colorLiteral(red: 1, green: 0.3882352941, blue: 0, alpha: 1),
				.underlineStyle: NSUnderlineStyle.single.rawValue
		]
		let attributeString = NSMutableAttributedString(
			string: "Не пришло?",
			 attributes: attributes
		)
		button.setAttributedTitle(attributeString, for: .normal)
		button.addTarget(self, action: #selector(errorSend), for: .touchUpInside)
		return button
	}()
	
	// MARK: - Lifecycle
	
	override func viewDidLoad() {
		super.viewDidLoad()
		setupViews()
		setupConstraints()
	}
	
	// MARK: - Button action
	
	@objc
	func errorSend() {
//		AuthManager.shared.signOut { _ in 
//			print("success")
//		}
	}
	
	// MARK: - SetupViews
	
	private func setupViews() {
		navigationItem.setBackBarItem()
		navigationItem.backBarButtonItem?.tintColor = .black
		view.backgroundColor = #colorLiteral(red: 0.7538307309, green: 0.8903734088, blue: 0.8967731595, alpha: 1)
		[titleLabel,
		 santaImageView,
		 enterStackView
		].forEach {
			view.addSubview($0)
		}
		
		[enterLabel, enterButton].forEach {
			enterStackView.addArrangedSubview($0)
		}
	}
	
	// MARK: - SetupConstraints
	
	private func setupConstraints() {
		
		titleLabel.snp.makeConstraints { make in
			make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
			make.centerX.equalToSuperview()
		}
		
		santaImageView.snp.makeConstraints { make in
			make.center.equalToSuperview()
			make.size.equalTo(300)
		}
		
		enterStackView.snp.makeConstraints { make in
			make.centerX.equalToSuperview()
			make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-90)
		}
	}
}
