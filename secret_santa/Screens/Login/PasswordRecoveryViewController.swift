//
//  PasswordRecoveryViewController.swift
//  secret_santa
//
//  Created by Mariya Aliyeva on 06.04.2024.
//

import UIKit

final class PasswordRecoveryViewController: UIViewController {
	
	// MARK: - UI
	
	private lazy var titleLabel = {
		let label = UILabel()
		label.textAlignment = .center
		label.font = UIFont(name: "DMSans-Bold", size: 22)
		label.text = "Восстановление доступа"
		return label
	}()
	
	private var emailLabel: UILabel = {
		let label = UILabel()
		label.text = "Ваш E-mail"
		label.font = UIFont(name: "DMSans-Regular", size: 15)
		return label
	}()
	
	private lazy var emailTextField: UITextField = {
		let textField = UITextField()
		textField.borderStyle = .roundedRect
	//	textField.delegate = self
		return textField
	}()
	
	private var sendLabel: UILabel = {
		let label = UILabel()
		label.text = "Мы отправим ссылку с временным паролем на Вашу почту"
		label.font = UIFont(name: "DMSans-Regular", size: 8)
		label.textColor = #colorLiteral(red: 0.5921568627, green: 0.5921568627, blue: 0.5921568627, alpha: 1)
		return label
	}()
	
	private lazy var button: UIButton = {
		let button = UIButton(type: .system)
		button.titleLabel?.font = UIFont(name: "DMSans-Bold", size: 15) ?? .boldSystemFont(ofSize: 15)
		button.backgroundColor = #colorLiteral(red: 1, green: 0.3882352941, blue: 0, alpha: 1)
		button.tintColor = .white
		button.setTitle("Восстановить", for: .normal)
		button.addTarget(self, action: #selector(recoveryPasswordTap), for: .touchUpInside)
		return button
	}()
	
	private lazy var termsLabel: UITextView = {
		let textView = UITextView()
		textView.isScrollEnabled = false
		textView.sizeToFit()
		textView.backgroundColor = #colorLiteral(red: 0.7538307309, green: 0.8903734088, blue: 0.8967731595, alpha: 1)
		var textForTextView = convertToAttribiteString()
		textView.linkTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.gray, NSAttributedString.Key.underlineStyle : NSUnderlineStyle.single.rawValue]
		textView.attributedText = textForTextView
		return textView
	}()
	
	// MARK: - Lifecycle
	
	override func viewDidLoad() {
		super.viewDidLoad()
		hideKeyboardWhenTappedAround()
		setupViews()
		setupConstraints()
	}
	
	override func viewWillLayoutSubviews() {
		super.viewWillLayoutSubviews()
		emailTextField.layer.cornerRadius = 20
		emailTextField.clipsToBounds = true
		button.layer.cornerRadius = 20
		button.clipsToBounds = true
	}
	
	func recoveryPassword() {
		PasswordManager.shared.recoveryPassword(email: emailTextField.text ?? "") { [weak self] response in
			switch response {
			case .success(let result):
				print(result)
				let controller = SendToEmailViewController()
				self?.navigationController?.pushViewController(controller, animated: true)
			case .failure(_):
				break
			}
		}
	}
	
	// MARK: - Button action
	
	@objc
	func recoveryPasswordTap() {
		recoveryPassword()
	}
	
	// MARK: - SetupViews
	
	private func setupViews() {
		navigationItem.setBackBarItem()
		navigationItem.backBarButtonItem?.tintColor = .black
		view.backgroundColor = #colorLiteral(red: 0.7538307309, green: 0.8903734088, blue: 0.8967731595, alpha: 1)
		[titleLabel,
		 emailLabel,
		 emailTextField,
		 sendLabel,
		 button,
		 termsLabel
		].forEach {
			view.addSubview($0)
		}
	}
	
	// MARK: - Private
	
	private func convertToAttribiteString() -> NSMutableAttributedString {
		let termsString = "Продолжая, вы даете согласие на обработку персональных данных"
		let attributedString = NSMutableAttributedString(string: termsString)
		let foundRange = attributedString.mutableString.range(of: "обработку персональных данных")
		let foundRange1 = attributedString.mutableString.range(of: "Продолжая, вы даете согласие на обработку персональных данных")
		attributedString.addAttribute(NSAttributedString.Key.link,
																	value: "https://www.youtube.com/watch?v=4-GZLogJ-w8&list=RD4-GZLogJ-w8&start_radio=1",
																	range: foundRange)
		attributedString.addAttribute(.underlineStyle,
																	value: NSUnderlineStyle.single.rawValue, range: foundRange)
		attributedString.addAttribute(.underlineColor,
																	value: UIColor.systemGray, range: foundRange)
		attributedString.addAttribute(.foregroundColor, value: UIColor.gray, range: foundRange1)
		attributedString.addAttribute(.font, value: UIFont(name: "DMSans-Regular", size: 8) ?? .systemFont(ofSize: 8), range: foundRange1)
		return attributedString
	}
	
	// MARK: - SetupConstraints
	
	private func setupConstraints() {
		
		titleLabel.snp.makeConstraints { make in
			make.top.equalTo(view.safeAreaLayoutGuide).offset(80)
			make.centerX.equalToSuperview()
		}
		
		emailLabel.snp.makeConstraints { make in
			make.top.equalTo(titleLabel.snp.bottom).offset(100)
			make.leading.trailing.equalToSuperview().inset(40)
		}
		
		emailTextField.snp.makeConstraints { make in
			make.top.equalTo(emailLabel.snp.bottom).offset(2)
			make.leading.trailing.equalToSuperview().inset(40)
		}
		
		sendLabel.snp.makeConstraints { make in
			make.top.equalTo(emailTextField.snp.bottom).offset(12)
			make.centerX.equalToSuperview()
		}
		
		button.snp.makeConstraints { make in
			make.height.equalTo(40)
			make.leading.trailing.equalToSuperview().inset(60)
			make.bottom.equalTo(termsLabel.snp.top).offset(-4)
		}
		
		termsLabel.snp.makeConstraints { make in
			make.centerX.equalToSuperview()
			make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-60)
		}
	}
}
