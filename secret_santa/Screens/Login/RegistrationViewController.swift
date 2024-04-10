//
//  RegistrationViewController.swift
//  secret_santa
//
//  Created by Mariya Aliyeva on 05.04.2024.
//

import UIKit

final class RegistrationViewController: UIViewController {
	
	// MARK: - Properties
	
	var token: String?
	private var emailText: String?
	private var passwordText: String?
	
	// MARK: - UI
	
	private lazy var titleLabel = {
		let label = UILabel()
		label.textAlignment = .center
		label.font = UIFont(name: "DMSans-Bold", size: 27)
		label.text = "Регистрация"
		return label
	}()
	
	private var nameLabel: UILabel = {
		let label = UILabel()
		label.text = "Email"
		label.font = UIFont(name: "DMSans-Regular", size: 15)
		return label
	}()
	
	private lazy var emailTextField: UITextField = {
		let textField = UITextField()
		textField.borderStyle = .roundedRect
	//	textField.delegate = self
		return textField
	}()
	
	private var emailLabel: UILabel = {
		let label = UILabel()
		label.text = "Пароль"
		label.font = UIFont(name: "DMSans-Regular", size: 15)
		return label
	}()
	
	private lazy var passwordTextField: UITextField = {
		let textField = UITextField()
		textField.borderStyle = .roundedRect
	//	textField.delegate = self
		return textField
	}()
	
	private lazy var dividerStackView = {
		let stackView = UIStackView()
		stackView.axis = .horizontal
		stackView.spacing = 10
		stackView.distribution = .fillProportionally
		stackView.alignment = .center
		return stackView
	}()
	
	private var dividerLabel: UILabel = {
		let label = UILabel()
		label.text = "или"
		label.font = UIFont(name: "DMSans-Regular", size: 10)
		label.textColor = #colorLiteral(red: 0.5921568627, green: 0.5921568627, blue: 0.5921568627, alpha: 1)
		return label
	}()
	
	private lazy var divider: UIImageView = {
		var view = UIImageView()
		view.image = UIImage(named: "divider")
		view.backgroundColor = .red
		return view
	}()
	
	private lazy var secondDivider: UIImageView = {
		var view = UIImageView()
		view.image = UIImage(named: "divider")
		view.backgroundColor = #colorLiteral(red: 0.5921568627, green: 0.5921568627, blue: 0.5921568627, alpha: 1)
		return view
	}()
	
	private lazy var googleButton: CustomButton = {
		let button = CustomButton(type: .system)
		button.configure(font: UIFont(name: "DMSans-Regular", size: 15) ?? .boldSystemFont(ofSize: 15))
		button.titleText = "Sing up with Google"
		button.backgroundColor = #colorLiteral(red: 0.8509803922, green: 0.8509803922, blue: 0.8509803922, alpha: 1)
		button.setTitleColor(.black, for: .normal)
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
	
	private lazy var button: UIButton = {
		let button = UIButton(type: .system)
		button.titleLabel?.font = UIFont(name: "DMSans-Bold", size: 15) ?? .boldSystemFont(ofSize: 15)
		button.backgroundColor = #colorLiteral(red: 1, green: 0.3882352941, blue: 0, alpha: 1)
		button.tintColor = .white
		button.setTitle("Зарегистрироваться", for: .normal)
		button.addTarget(self, action: #selector(registTap), for: .touchUpInside)
		return button
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
		label.text = "Уже есть аккаунт?"
		label.font = UIFont(name: "DMSans-Regular", size: 8)
		label.textColor = #colorLiteral(red: 0.5921568627, green: 0.5921568627, blue: 0.5921568627, alpha: 1)
		return label
	}()
	
	private lazy var enterButton: UIButton = {
		let button = UIButton(type: .system)
		let attributes: [NSAttributedString.Key: Any] = [
			.font: UIFont(name: "DMSans-Regular", size: 8) ?? .systemFont(ofSize: 8),
				.foregroundColor: #colorLiteral(red: 0.5921568627, green: 0.5921568627, blue: 0.5921568627, alpha: 1),
				.underlineStyle: NSUnderlineStyle.single.rawValue
		]
		let attributeString = NSMutableAttributedString(
			string: "Войти.",
			 attributes: attributes
		)
		button.setAttributedTitle(attributeString, for: .normal)
		button.addTarget(self, action: #selector(enterTap), for: .touchUpInside)
		return button
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
		
		guard let email = emailTextField.text else {return}
		guard let password = passwordTextField.text else {return}
		
		
		AuthManager.shared.exchangeCodeForToken(email: email, password: password) { [weak self] result in
			switch result {
			case .success(let response):
				self?.token = response.token
				let tabbarViewController = MainTabBarViewController()
				tabbarViewController.modalPresentationStyle = .fullScreen
				self?.present(tabbarViewController, animated: true)
			case .failure(_):
				break
			}
		}
	}
	
	// MARK: - Button action
	
	@objc
	func registTap() {
		getToken()
		
//		let tabbarViewController = MainTabBarViewController()
//		tabbarViewController.modalPresentationStyle = .fullScreen
//		present(tabbarViewController, animated: true)
	}
	
	@objc
	func enterTap() {
		let enterVC = EnterViewController()
		navigationController?.pushViewController(enterVC, animated: true)
	}
	
	// MARK: - Private
	
	private func convertToAttribiteString() -> NSMutableAttributedString {
		let termsString = "Регистрируясь, вы даете согласие на обработку персональных данных"
		let attributedString = NSMutableAttributedString(string: termsString)
		let foundRange = attributedString.mutableString.range(of: "обработку персональных данных")
		let foundRange1 = attributedString.mutableString.range(of: "Регистрируясь, вы даете согласие на обработку персональных данных")
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
		 emailLabel,
		 passwordTextField,
		 dividerStackView,
		 googleButton,
		 termsLabel,
		 button,
		 enterStackView
		].forEach {
			view.addSubview($0)
		}
		
		[divider, dividerLabel, secondDivider].forEach {
			dividerStackView.addArrangedSubview($0)
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
		
		nameLabel.snp.makeConstraints { make in
			make.top.equalTo(titleLabel.snp.bottom).offset(54)
			make.leading.trailing.equalToSuperview().inset(35)
		}
		
		emailTextField.snp.makeConstraints { make in
			make.top.equalTo(nameLabel.snp.bottom).offset(2)
			make.leading.trailing.equalToSuperview().inset(35)
		}
		
		emailLabel.snp.makeConstraints { make in
			make.top.equalTo(emailTextField.snp.bottom).offset(8)
			make.leading.trailing.equalToSuperview().inset(35)
		}
		
		passwordTextField.snp.makeConstraints { make in
			make.top.equalTo(emailLabel.snp.bottom).offset(2)
			make.leading.trailing.equalToSuperview().inset(35)
		}
		
		dividerStackView.snp.makeConstraints { make in
			make.top.equalTo(passwordTextField.snp.bottom).offset(24)
			make.leading.trailing.equalToSuperview().inset(35)
		}
		
		googleButton.snp.makeConstraints { make in
			make.top.equalTo(dividerStackView.snp.bottom).offset(20)
			make.leading.trailing.equalToSuperview().inset(35)
			make.height.equalTo(40)
		}
		
		termsLabel.snp.makeConstraints { make in
			make.top.equalTo(googleButton.snp.bottom).offset(12)
			make.centerX.equalToSuperview()
		}
		
		button.snp.makeConstraints { make in
			make.height.equalTo(40)
			make.leading.trailing.equalToSuperview().inset(74)
			make.bottom.equalTo(enterStackView.snp.top).offset(-4)
		}
		
		enterStackView.snp.makeConstraints { make in
			make.centerX.equalToSuperview()
			make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-60)
		}
	}
}
