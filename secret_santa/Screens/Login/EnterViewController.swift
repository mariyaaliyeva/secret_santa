//
//  EnterViewController.swift
//  secret_santa
//
//  Created by Mariya Aliyeva on 06.04.2024.
//

import UIKit

final class EnterViewController: UIViewController {
	
	// MARK: - UI
	private lazy var titleLabel = {
		let label = UILabel()
		label.textAlignment = .center
		label.font = UIFont(name: "DMSans-Bold", size: 27)
		label.text = "Вход"
		return label
	}()
	
	private var nameLabel: UILabel = {
		let label = UILabel()
		label.text = "Ваше email"
		label.font = UIFont(name: "DMSans-Regular", size: 15)
		return label
	}()
	
	private lazy var emailTextField: UITextField = {
		let textField = UITextField()
		textField.borderStyle = .roundedRect
		// textField.delegate = self
		return textField
	}()
	
	private var passwordLabel: UILabel = {
		let label = UILabel()
		label.text = "Пароль"
		label.font = UIFont(name: "DMSans-Regular", size: 15)
		return label
	}()
	
	private var wrongPasswordLabel: UILabel = {
		let label = UILabel()
		label.text = "Неверный пароль"
		label.isHidden = true
		label.textColor = .red
		label.textAlignment = .left
		label.font = UIFont(name: "DMSans-Medium", size: 10)
		return label
	}()
	
	private lazy var passwordTextField: UITextField = {
		let textField = UITextField()
		textField.borderStyle = .roundedRect
	//	textField.isSecureTextEntry = true
		//	textField.delegate = self
		return textField
	}()
	
	private lazy var forgotPasswordButton: UIButton = {
		let button = UIButton(type: .system)
		let attributes: [NSAttributedString.Key: Any] = [
			.font: UIFont(name: "DMSans-Regular", size: 10) ?? .systemFont(ofSize: 8),
				.foregroundColor: #colorLiteral(red: 0.5921568627, green: 0.5921568627, blue: 0.5921568627, alpha: 1),
				.underlineStyle: NSUnderlineStyle.single.rawValue
		]
		let attributeString = NSMutableAttributedString(
			string: "Забыли пароль?",
			 attributes: attributes
		)
		button.setAttributedTitle(attributeString, for: .normal)
		button.addTarget(self, action: #selector(forgotPasswordTap), for: .touchUpInside)
		return button
	}()
	
	private lazy var button: UIButton = {
		let button = UIButton(type: .system)
		button.titleLabel?.font = UIFont(name: "DMSans-Bold", size: 15) ?? .boldSystemFont(ofSize: 15)
		button.backgroundColor = #colorLiteral(red: 1, green: 0.3882352941, blue: 0, alpha: 1)
		button.tintColor = .white
		button.setTitle("Войти", for: .normal)
		button.addTarget(self, action: #selector(enterTap), for: .touchUpInside)
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
		passwordTextField.layer.cornerRadius = 20
		passwordTextField.clipsToBounds = true
		button.layer.cornerRadius = 20
		button.clipsToBounds = true
	}
	
	func getToken() {
		
		AuthManager.shared.getTokenWhenLogin(email: emailTextField.text ?? "", password: passwordTextField.text ?? "") { [weak self] result in
			switch result {
			case .success(let response):
				print(response.token)
				let tabbarViewController = MainTabBarViewController()
				tabbarViewController.modalPresentationStyle = .fullScreen
				self?.present(tabbarViewController, animated: true)
			case .failure(_):
				self?.passwordTextField.layer.borderWidth = 1
				self?.passwordTextField.layer.borderColor = UIColor.red.cgColor
				self?.wrongPasswordLabel.isHidden = false
			}
		}
	}
	
	// MARK: - Button action
	
	@objc
	func forgotPasswordTap() {
		let controller = PasswordRecoveryViewController()
		navigationController?.pushViewController(controller, animated: true)
	}
	
	@objc
	func enterTap() {
     getToken()
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
	
	// MARK: - SetupViews
	
	private func setupViews() {
		navigationItem.setBackBarItem()
		navigationItem.backBarButtonItem?.tintColor = .black
		view.backgroundColor = #colorLiteral(red: 0.7538307309, green: 0.8903734088, blue: 0.8967731595, alpha: 1)
		[titleLabel,
		 nameLabel,
		 emailTextField,
		 passwordLabel,
		 wrongPasswordLabel,
		 passwordTextField,
		 forgotPasswordButton,
		 button,
		 termsLabel
		].forEach {
			view.addSubview($0)
		}
	}
	
	// MARK: - SetupConstraints
	
	private func setupConstraints() {
		
		titleLabel.snp.makeConstraints { make in
			make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
			make.centerX.equalToSuperview()
		}
		
		nameLabel.snp.makeConstraints { make in
			make.top.equalTo(titleLabel.snp.bottom).offset(54)
			make.leading.trailing.equalToSuperview().inset(35)
		}
		
		emailTextField.snp.makeConstraints { make in
			make.top.equalTo(nameLabel.snp.bottom).offset(2)
			make.leading.trailing.equalToSuperview().inset(35)
		}
		
		passwordLabel.snp.makeConstraints { make in
			make.top.equalTo(emailTextField.snp.bottom).offset(8)
			make.leading.equalToSuperview().inset(35)
		}
		
		wrongPasswordLabel.snp.makeConstraints { make in
			make.bottom.equalTo(passwordTextField.snp.top).offset(-3)
			make.trailing.equalToSuperview().offset(-40)
		}
		
		passwordTextField.snp.makeConstraints { make in
			make.top.equalTo(passwordLabel.snp.bottom).offset(2)
			make.leading.trailing.equalToSuperview().inset(35)
		}
		
		forgotPasswordButton.snp.makeConstraints { make in
			make.centerX.equalToSuperview()
			make.top.equalTo(passwordTextField.snp.bottom).offset(16)
		}
		
		button.snp.makeConstraints { make in
			make.height.equalTo(40)
			make.leading.trailing.equalToSuperview().inset(74)
			make.bottom.equalTo(termsLabel.snp.top).offset(-4)
		}
		
		termsLabel.snp.makeConstraints { make in
			make.centerX.equalToSuperview()
			make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-60)
		}
	}
}
