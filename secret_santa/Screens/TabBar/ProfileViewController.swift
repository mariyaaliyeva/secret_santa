//
//  ProfileViewController.swift
//  secret_santa
//
//  Created by Mariya Aliyeva on 06.04.2024.
//

import UIKit

final class ProfileViewController: BaseViewController {
	
	// MARK: - Properties
	
	private var currentLanguage: SupportedLanguages? {
			didSet {
					guard let currentLanguage else { return }
					//Создаем функцию смены языка
					didChange(language: currentLanguage)
			}
	}
	
	// MARK: - UI
	
	private lazy var scrollView: UIScrollView = {
		let scroll = UIScrollView()
		scroll.backgroundColor = .clear
		scroll.showsHorizontalScrollIndicator = false
		scroll.showsVerticalScrollIndicator = false
		scroll.contentInset = .zero
		return scroll
	}()
	
	private var contentView: UIStackView = {
		let stackView = UIStackView()
		stackView.backgroundColor = .clear
		stackView.axis = .vertical
		stackView.spacing = 20
		stackView.alignment = .center
		return stackView
	}()
	
	private lazy var titleView: UIView = {
		let view = UIView()
		view.backgroundColor = .white
		return view
	}()
	
	private lazy var circleView: UIView = {
		let view = UIView()
		view.backgroundColor = #colorLiteral(red: 1, green: 0.3882352941, blue: 0, alpha: 1)
		return view
	}()
	
	private var titleContentView: UIStackView = {
		let stackView = UIStackView()
		stackView.backgroundColor = .clear
		stackView.axis = .vertical
		stackView.spacing = 2
		stackView.alignment = .center
		return stackView
	}()
	
	private var nameExampleLabel: UILabel = {
		let label = UILabel()
		label.text = "Имя Фамилия"
		label.font = UIFont(name: "DMSans-Regular", size: 15)
		return label
	}()
	
	private var emailExampleLabel: UILabel = {
		let label = UILabel()
		label.text = "example@gmail.com"
		label.font = UIFont(name: "DMSans-Regular", size: 10)
		return label
	}()
	
	private lazy var titleLabel = {
		let label = UILabel()
		label.textAlignment = .center
		label.font = UIFont(name: "DMSans-Bold", size: 20)
		label.text = "Personal_data".localized
		return label
	}()
	
	private var emailTextFieldView: UIStackView = {
		let stackView = UIStackView()
		stackView.backgroundColor = .clear
		stackView.axis = .vertical
		stackView.spacing = 2
		stackView.alignment = .leading
		return stackView
	}()
	
	private var nameLabel: UILabel = {
		let label = UILabel()
		label.text = "Ваше имя"
		label.font = UIFont(name: "DMSans-Regular", size: 15)
		return label
	}()
	
	private lazy var nameTextField: UITextField = {
		let textField = UITextField()
		textField.borderStyle = .roundedRect
		textField.placeholder = "*Имя Фамилия*"
	//	textField.delegate = self
		return textField
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
		textField.placeholder = "example@gmail.com"
	//	textField.delegate = self
		return textField
	}()
	
	private lazy var savePersonalDataButton: UIButton = {
		let button = UIButton(type: .system)
		let attributes: [NSAttributedString.Key: Any] = [
			.font: UIFont(name: "DMSans-Regular", size: 13) ?? .systemFont(ofSize: 13),
				.foregroundColor: #colorLiteral(red: 0.5921568627, green: 0.5921568627, blue: 0.5921568627, alpha: 1)
		]
		let attributeString = NSMutableAttributedString(
			string: "Сохранить",
			 attributes: attributes
		)
		button.setAttributedTitle(attributeString, for: .normal)
		button.addTarget(self, action: #selector(saveTap), for: .touchUpInside)
		return button
	}()
	
	private lazy var titleLanguageLabel = {
		let label = UILabel()
		label.textAlignment = .center
		label.font = UIFont(name: "DMSans-Bold", size: 20)
		label.text = "Сменить Язык"
		return label
	}()
	
	private lazy var languageTextField: UITextField = {
		let textField = UITextField()
		textField.borderStyle = .roundedRect
		textField.placeholder = "Русский"
		textField.rightView = changeLanguageButton
		textField.rightViewMode = .always
	//	textField.delegate = self
		return textField
	}()
	
	private lazy var changeLanguageButton: UIButton = {
		let button = UIButton(type: .system)
		button.tintColor = #colorLiteral(red: 0.5921568627, green: 0.5921568627, blue: 0.5921568627, alpha: 1)
		button.imageEdgeInsets = UIEdgeInsets(top: 0, left: -16, bottom: 0, right: 0)
		button.setImage(UIImage(named: "change_icon"), for: .normal)
		button.addTarget(self, action: #selector(changeLanguageTap), for: .touchUpInside)
		return button
	}()
	
	private lazy var passwordTitleLabel = {
		let label = UILabel()
		label.textAlignment = .center
		label.font = UIFont(name: "DMSans-Bold", size: 20)
		label.text = "Пароль"
		return label
	}()
	
	private var newPasswordTextFieldView: UIStackView = {
		let stackView = UIStackView()
		stackView.backgroundColor = .clear
		stackView.axis = .vertical
		stackView.spacing = 2
		stackView.alignment = .leading
		return stackView
	}()
	
	private var newPasswordLabel: UILabel = {
		let label = UILabel()
		label.text = "Email"
		label.font = UIFont(name: "DMSans-Regular", size: 15)
		return label
	}()
	
	private lazy var newPasswordTextField: UITextField = {
		let textField = UITextField()
		textField.borderStyle = .roundedRect
	//	textField.delegate = self
		return textField
	}()
	
	private var repeatPasswordLabel: UILabel = {
		let label = UILabel()
		label.text = "Повторите пароль"
		label.font = UIFont(name: "DMSans-Regular", size: 15)
		return label
	}()
	
	private lazy var repeatPasswordTextField: UITextField = {
		let textField = UITextField()
		textField.borderStyle = .roundedRect
	//	textField.delegate = self
		return textField
	}()
	
	private lazy var afterLanguageView: UIView = {
		let view = UIView()
		view.backgroundColor = .clear
		return view
	}()
	
	private lazy var savePasswordButton: UIButton = {
		let button = UIButton(type: .system)
		let attributes: [NSAttributedString.Key: Any] = [
			.font: UIFont(name: "DMSans-Regular", size: 13) ?? .systemFont(ofSize: 13),
				.foregroundColor: #colorLiteral(red: 0.5921568627, green: 0.5921568627, blue: 0.5921568627, alpha: 1)
		]
		let attributeString = NSMutableAttributedString(
			string: "Сохранить",
			 attributes: attributes
		)
		button.setAttributedTitle(attributeString, for: .normal)
		button.addTarget(self, action: #selector(savePassword), for: .touchUpInside)
		return button
	}()
	
	private lazy var beforeButtonView: UIView = {
		let view = UIView()
		view.backgroundColor = .clear
		return view
	}()
	
	private lazy var button: UIButton = {
		let button = UIButton(type: .system)
		button.titleLabel?.font = UIFont(name: "DMSans-Medium", size: 15) ?? .boldSystemFont(ofSize: 15)
		button.backgroundColor = .red
		button.tintColor = .white
		button.setTitle("Удалить аккаунт", for: .normal)
		button.addTarget(self, action: #selector(deleteAccountTap), for: .touchUpInside)
		return button
	}()
	
	private lazy var bottomView: UIView = {
		let view = UIView()
		view.backgroundColor = .clear
		return view
	}()
	
	// MARK: - Lifecycle
	
	override func viewDidLoad() {
		super.viewDidLoad()
		setupViews()
		setupConstraints()
		getUserInfo()
	}
	
	override func viewWillLayoutSubviews() {
		super.viewWillLayoutSubviews()
		titleView.layer.cornerRadius = 20
		titleView.clipsToBounds = true
		titleView.layer.borderWidth = 3
		titleView.layer.borderColor = #colorLiteral(red: 1, green: 0.3882352941, blue: 0, alpha: 1)
		circleView.clipsToBounds = true
		circleView.layer.cornerRadius = 20
		nameTextField.layer.cornerRadius = 20
		nameTextField.clipsToBounds = true
		emailTextField.layer.cornerRadius = 20
		emailTextField.clipsToBounds = true
		languageTextField.layer.cornerRadius = 20
		languageTextField.clipsToBounds = true
		newPasswordTextField.layer.cornerRadius = 20
		newPasswordTextField.clipsToBounds = true
		repeatPasswordTextField.layer.cornerRadius = 20
		repeatPasswordTextField.clipsToBounds = true
		button.layer.cornerRadius = 20
		button.clipsToBounds = true
	}
	
	override func setupTitles() {
		titleLabel.text = "Personal_data".localized
	}
	
	private func deleteUser() {
		DeleteUser.shared.deleteUser { _ in
			print("Success")
		}
	}
	
	private func updateUser() {

		UpdateUserGeneralManager.shared.updateUserInfo(name: nameTextField.text ?? "", email: emailTextField.text ?? "", image: 0) { [weak self] result in
			switch result {
				
			case .success(let response):

				print(response.fullName)
			case .failure(_):
				break
			}
		}
	}
	
	private func updatePassword() {
		UpdateUserGeneralManager.shared.updateUserPassword(email: newPasswordTextField.text ?? "", password: repeatPasswordTextField.text ?? "") { _ in
			print("Success!")
		}
	}
	
	private func getUserInfo() {
		UserInfoManager.shared.getUserInfo { [weak self] result in
			switch result {
				
			case .success(let response):
				if response.fullName != nil {
					self?.nameTextField.text = response.fullName
				}
				if response.email != nil {
					self?.emailTextField.text = response.email
				}

			case .failure(_):
				break
			}
		}
	}
	
	// MARK: - Button action
	
	@objc
	func saveTap() {
		updateUser()
	}
	
	@objc
	func changeLanguageTap() {
		let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
		SupportedLanguages.all.forEach { language in
				alert.addAction(
						.init(
								title: language.localizedTitle,
								style: .default,
								handler: { [weak self] _ in
								//Вызываем переменную currentLanguage
										self?.currentLanguage = language
								}
						)
				)
		}
		
		alert.addAction(.init(title: "Cancel".localized, style: .cancel))
		self.present(alert, animated: true, completion: nil)
	}
	
	@objc
	func savePassword() {
		updatePassword()
	}
	
	@objc
	func deleteAccountTap() {
		deleteUser()
		AuthManager.shared.signOut { _ in
			print("success")
		}
		let controller = StartViewController()
		controller.modalPresentationStyle = .overFullScreen
		present(controller, animated: true)
	}
	
	private func didChange(language: SupportedLanguages) {
			Bundle.setLanguage(language: language.rawValue)
			DispatchQueue.main.async {
			//Observer
					NotificationCenter.default.post(name: NSNotification.Name("language"), object: nil)
			}
	}
 
	// MARK: - Setup Views
	
	private func setupViews() {
		view.backgroundColor = #colorLiteral(red: 0.7538307309, green: 0.8903734088, blue: 0.8967731595, alpha: 1)
		view.addSubview(scrollView)
		scrollView.addSubview(contentView)
		
		[titleView,
		 titleLabel,
		 emailTextFieldView,
		 savePersonalDataButton,
		 titleLanguageLabel,
		 languageTextField,
		 afterLanguageView,
		 passwordTitleLabel,
		 newPasswordTextFieldView,
		 savePasswordButton,
		 beforeButtonView,
		 button,
		 bottomView
		].forEach {
			contentView.addArrangedSubview($0)
		}
		
		[circleView, titleContentView].forEach {
			titleView.addSubview($0)
		}
		
		[nameExampleLabel, emailExampleLabel].forEach {
			titleContentView.addArrangedSubview($0)
		}
		
		[nameLabel,
		 nameTextField,
		 emailLabel,
		 emailTextField].forEach {
			emailTextFieldView.addArrangedSubview($0)
		}
		
		[newPasswordLabel,
		 newPasswordTextField,
		 repeatPasswordLabel,
		 repeatPasswordTextField].forEach {
			newPasswordTextFieldView.addArrangedSubview($0)
		}
	}
	
	// MARK: - Setup Constraints
	private func setupConstraints() {
		
		scrollView.snp.makeConstraints { make in
			make.top.equalTo(view.safeAreaLayoutGuide)
			make.leading.trailing.bottom.equalToSuperview()
		}
		
		contentView.snp.makeConstraints { make in
			make.top.equalTo(scrollView).offset(12)
			make.bottom.equalTo(scrollView)
			make.width.equalTo(view.frame.width)
		}
		
		titleView.snp.makeConstraints { make in
			make.leading.trailing.equalTo(contentView).inset(35)
			make.height.equalTo(55)
		}
		
		circleView.snp.makeConstraints { make in
			make.centerY.equalToSuperview()
			make.size.equalTo(40)
			make.leading.equalToSuperview().offset(14)
		}
		
		titleContentView.snp.makeConstraints { make in
			make.leading.equalTo(circleView.snp.trailing).offset(12)
			make.centerY.equalToSuperview()
		}
		
		titleLabel.snp.makeConstraints { make in
			make.centerX.equalToSuperview()
		}
		
		emailTextFieldView.snp.makeConstraints { make in
			make.leading.trailing.equalToSuperview().inset(35)
		}
		
		afterLanguageView.snp.makeConstraints { make in
			make.height.equalTo(30)
		}
		
		nameTextField.snp.makeConstraints { make in
			make.height.equalTo(40)
			make.leading.trailing.equalToSuperview()
		}
		
		emailTextField.snp.makeConstraints { make in
			make.height.equalTo(40)
			make.leading.trailing.equalToSuperview()
		}
		
		titleLanguageLabel.snp.makeConstraints { make in
			make.top.equalTo(savePersonalDataButton.snp.bottom).offset(34)
		}
		
		languageTextField.snp.makeConstraints { make in
			make.height.equalTo(40)
			make.leading.trailing.equalToSuperview().inset(35)
		}

		newPasswordTextFieldView.snp.makeConstraints { make in
			make.leading.trailing.equalToSuperview().inset(35)
		}
		
		newPasswordTextField.snp.makeConstraints { make in
			make.height.equalTo(40)
			make.leading.trailing.equalToSuperview()
		}
		
		repeatPasswordTextField.snp.makeConstraints { make in
			make.height.equalTo(40)
			make.leading.trailing.equalToSuperview()
		}
		
		beforeButtonView.snp.makeConstraints { make in
			make.height.equalTo(54)
		}
		
		button.snp.makeConstraints { make in
			make.height.equalTo(35)
			make.leading.trailing.equalToSuperview().inset(35)
		}
		
		bottomView.snp.makeConstraints { make in
			make.height.equalTo(35)
		}
	}
}
