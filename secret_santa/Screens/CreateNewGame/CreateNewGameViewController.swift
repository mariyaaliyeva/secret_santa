//
//  CreateNewGameViewController.swift
//  secret_santa
//
//  Created by Mariya Aliyeva on 07.04.2024.
//

import UIKit

final class CreateNewGameViewController: UIViewController {
	
	// MARK: - Props
	
	let pickerElements = ["KZT", "USD"]
	
	// MARK: - UI
	
	private lazy var titleLabel = {
		let label = UILabel()
		label.textAlignment = .center
		label.font = UIFont(name: "DMSans-Bold", size: 27)
		label.text = "Создать игру"
		return label
	}()
	
	private var nameLabel: UILabel = {
		let label = UILabel()
		label.text = "Название Игры"
		label.font = UIFont(name: "DMSans-Regular", size: 15)
		return label
	}()
	
	private lazy var nameTextField: UITextField = {
		let textField = UITextField()
		textField.borderStyle = .roundedRect
		textField.delegate = self
		return textField
	}()
	
	private var emailLabel: UILabel = {
		let label = UILabel()
		label.text = "Идентификатор"
		label.font = UIFont(name: "DMSans-Regular", size: 15)
		return label
	}()
	
	private lazy var idView: UIView = {
		let view = UIView()
		view.backgroundColor = .white
		return view
	}()
	
	private var randomLabel: UILabel = {
		let label = UILabel()
		label.textColor = #colorLiteral(red: 0.5921568627, green: 0.5921568627, blue: 0.5921568627, alpha: 1)
		let num = UUID().hashValue
		label.text = "\(num)"
		label.isHidden = true
		label.font = UIFont(name: "DMSans-Regular", size: 15)
		return label
	}()
	
	private var sendLabel: UILabel = {
		let label = UILabel()
		label.text = "Придумайте уникальный идентификатор для коробки, который будет указываться в ссылке"
		label.font = UIFont(name: "DMSans-Bold", size: 8)
		label.textColor = #colorLiteral(red: 0.5921568627, green: 0.5921568627, blue: 0.5921568627, alpha: 1)
		label.textAlignment = .center
		return label
	}()
	
	private lazy var titleView: UIView = {
		let view = UIView()
		view.backgroundColor = .white
		return view
	}()
	
	private var nameExampleLabel: UILabel = {
		let label = UILabel()
		label.text = "Максимальная стоимость подарка"
		label.font = UIFont(name: "DMSans-Medium", size: 10)
		return label
	}()
	
	private lazy var isPriceSwitch: UISwitch = {
		let fillSwitch = UISwitch()
		fillSwitch.onTintColor = #colorLiteral(red: 0.3529411765, green: 0.7254901961, blue: 0.7490196078, alpha: 1)
		fillSwitch.thumbTintColor = #colorLiteral(red: 0.7529411765, green: 0.8901960784, blue: 0.8980392157, alpha: 1)
		fillSwitch.backgroundColor = #colorLiteral(red: 0.003921568627, green: 0.4705882353, blue: 0.4941176471, alpha: 1)
		fillSwitch.addTarget(self, action: #selector(priceButton), for: .valueChanged)
		return fillSwitch
	}()
	
	private var condLabel: UILabel = {
		let label = UILabel()
		label.text = "При включенной опции участникам будет показано ограничение, которому они должны будут следовать"
		label.font = UIFont(name: "DMSans-Bold", size: 8)
		label.textColor = #colorLiteral(red: 0.5921568627, green: 0.5921568627, blue: 0.5921568627, alpha: 1)
		label.textAlignment = .center
		return label
	}()
	
	private lazy var currenceView: UIView = {
		let view = UIView()
		view.backgroundColor = .white
		view.isHidden = true
		return view
	}()
	
	private lazy var currencyTextField: UITextField = {
		let textField = UITextField()
		textField.borderStyle = .none
		textField.keyboardType = .numberPad
		textField.textAlignment = .right
		let attributes = [
			NSAttributedString.Key.font : UIFont(name: "DMSans-Medium", size: 10)!
		]
		textField.attributedPlaceholder = NSAttributedString(string: "Укажите максимальную стоимость подарка", attributes:attributes)
		return textField
	}()
	
	private lazy var button: CustomButton = {
		let button = CustomButton(type: .system)
		button.configure(font: UIFont(name: "DMSans-Bold", size: 15) ?? .boldSystemFont(ofSize: 15))
		button.titleText = "Создать игру"
		button.addTarget(self, action: #selector(createGameTap), for: .touchUpInside)
		return button
	}()
	
	private lazy var verticalImageView = {
		let image = UIImageView()
		image.contentMode = .scaleAspectFit
		image.image = UIImage(named: "vertical")
		return image
	}()
	
	private lazy var pickerShowbutton: UIButton = {
		let button = UIButton(type: .system)
		button.tintColor = #colorLiteral(red: 0.5921568627, green: 0.5921568627, blue: 0.5921568627, alpha: 1)
		button.setImage(UIImage(named: "change_icon"), for: .normal)
		button.addTarget(self, action: #selector(showPicketTap), for: .touchUpInside)
		return button
	}()
	
	private var currencyLabel: UILabel = {
		let label = UILabel()
		label.text = "Валюта"
		label.textColor = #colorLiteral(red: 0.5921568627, green: 0.5921568627, blue: 0.5921568627, alpha: 1)
		label.font = UIFont(name: "DMSans-Medium", size: 10)
		return label
	}()
	
	private lazy var picker: UIPickerView = {
		let picker = UIPickerView()
		picker.isHidden = true
		picker.delegate = self
		picker.dataSource = self
		return picker
	}()
	
	// MARK: - Lifecycle
	
	override func viewDidLoad() {
		super.viewDidLoad()
		hideKeyboardWhenTappedAround()
		setupViews()
		setupConstraints()
		nameTextField.becomeFirstResponder()
		button.isEnabled = false
		button.alpha = 0.5
		
		currencyTextField.addTarget(self, action: #selector(editingChanged), for: .editingChanged)
	}
	
	override func viewWillLayoutSubviews() {
		super.viewWillLayoutSubviews()
		nameTextField.layer.cornerRadius = 20
		nameTextField.clipsToBounds = true
		idView.layer.cornerRadius = 20
		idView.clipsToBounds = true
		titleView.layer.cornerRadius = 20
		titleView.clipsToBounds = true
		button.layer.cornerRadius = 20
		button.clipsToBounds = true
		isPriceSwitch.layer.cornerRadius = 16
		currenceView.layer.cornerRadius = 15
		currenceView.clipsToBounds = true
	}
	
	// MARK: - Button action
	
	@objc
	func createGameTap() {
		let controller = SuccessCreateGameViewController()
		navigationController?.pushViewController(controller, animated: true)
	}
	
	@objc
	func priceButton(_ sender: UISwitch) {
		if sender .isOn {
			currenceView.isHidden = false
			currenceView.layer.borderWidth = 1
			currenceView.layer.borderColor = UIColor.clear.cgColor
			currencyLabel.textColor = #colorLiteral(red: 0.5921568627, green: 0.5921568627, blue: 0.5921568627, alpha: 1)
			verticalImageView.image = UIImage(named: "vertical")
			pickerShowbutton.tintColor = #colorLiteral(red: 0.5921568627, green: 0.5921568627, blue: 0.5921568627, alpha: 1)
			currencyTextField.attributedPlaceholder = NSAttributedString(
					string: "Укажите максимальную стоимость подарка",
					attributes: [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.5921568627, green: 0.5921568627, blue: 0.5921568627, alpha: 1), NSAttributedString.Key.font : UIFont(name: "DMSans-Medium", size: 10)!]
			)
			currencyTextField.becomeFirstResponder()
			button.isEnabled = false
			button.alpha = 0.5
		} else {
			currenceView.isHidden = true
			picker.isHidden = true
			button.isEnabled = true
			button.alpha = 1.0
		}
	}
	
	@objc func editingChanged(_ textField: UITextField) {
		
		if currencyTextField.text?.count == 1 {
			if currencyTextField.text?.first == " " {
				currencyTextField.text = ""
				return
			}
		}
		guard
			let phone = currencyTextField.text, !phone.isEmpty
		else {
			currenceView.layer.borderWidth = 1
			currenceView.layer.borderColor = UIColor.red.cgColor
			currencyLabel.textColor = .red
			verticalImageView.image = UIImage(named: "red_line")
			pickerShowbutton.tintColor = .red
			currencyTextField.attributedPlaceholder = NSAttributedString(
				string: "Укажите максимальную стоимость подарка",
				attributes: [NSAttributedString.Key.foregroundColor: UIColor.red, NSAttributedString.Key.font : UIFont(name: "DMSans-Medium", size: 10)!]
			)
			button.isEnabled = false
			button.alpha = 0.5
			return
		}
		currenceView.layer.borderWidth = 1
		currenceView.layer.borderColor = UIColor.clear.cgColor
		currencyLabel.textColor = #colorLiteral(red: 0.5921568627, green: 0.5921568627, blue: 0.5921568627, alpha: 1)
		verticalImageView.image = UIImage(named: "vertical")
		pickerShowbutton.tintColor = #colorLiteral(red: 0.5921568627, green: 0.5921568627, blue: 0.5921568627, alpha: 1)
		currencyTextField.attributedPlaceholder = NSAttributedString(
				string: "Укажите максимальную стоимость подарка",
				attributes: [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.5921568627, green: 0.5921568627, blue: 0.5921568627, alpha: 1), NSAttributedString.Key.font : UIFont(name: "DMSans-Medium", size: 10)!]
		)
		button.isEnabled = true
		button.alpha = 1.0
	
	}
	
	@objc
	func showPicketTap() {
		picker.isHidden = false
	}
	
	// MARK: - SetupViews
	
	private func setupViews() {
	//	tabBarController?.tabBar.isHidden = true
		navigationItem.setBackBarItem()
		navigationItem.backBarButtonItem?.tintColor = .black
		view.backgroundColor = #colorLiteral(red: 0.7538307309, green: 0.8903734088, blue: 0.8967731595, alpha: 1)
		[titleLabel,
		 nameLabel,
		 nameTextField,
		 emailLabel,
		 idView,
		 sendLabel,
		 titleView,
		 condLabel,
		 currenceView,
		 picker,
		 button
		].forEach {
			view.addSubview($0)
		}
		
		idView.addSubview(randomLabel)
		
		[nameExampleLabel, isPriceSwitch].forEach {
			titleView.addSubview($0)
		}
		
		[currencyTextField, verticalImageView, currencyLabel, pickerShowbutton].forEach {
			currenceView.addSubview($0)
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
		
		nameTextField.snp.makeConstraints { make in
			make.top.equalTo(nameLabel.snp.bottom).offset(2)
			make.leading.trailing.equalToSuperview().inset(35)
			make.height.equalTo(40)
		}
		
		emailLabel.snp.makeConstraints { make in
			make.top.equalTo(nameTextField.snp.bottom).offset(8)
			make.leading.trailing.equalToSuperview().inset(35)
		}
		
		idView.snp.makeConstraints { make in
			make.top.equalTo(emailLabel.snp.bottom).offset(2)
			make.leading.trailing.equalToSuperview().inset(35)
			make.height.equalTo(40)
		}
		
		randomLabel.snp.makeConstraints { make in
			make.centerY.equalToSuperview()
			make.leading.equalToSuperview().offset(12)
		}
	
		sendLabel.snp.makeConstraints { make in
			make.top.equalTo(idView.snp.bottom).offset(12)
			make.leading.trailing.equalToSuperview().inset(35)
		}
		
		titleView.snp.makeConstraints { make in
			make.top.equalTo(sendLabel.snp.bottom).offset(12)
			make.leading.trailing.equalToSuperview().inset(35)
			make.height.equalTo(40)
		}
		
		nameExampleLabel.snp.makeConstraints { make in
			make.centerY.equalToSuperview()
			make.leading.equalToSuperview().offset(12)
		}
		
		isPriceSwitch.snp.makeConstraints { make in
			make.centerY.equalToSuperview()
			make.trailing.equalToSuperview().offset(-12)
		}
		
		condLabel.snp.makeConstraints { make in
			make.top.equalTo(titleView.snp.bottom).offset(12)
			make.leading.trailing.equalToSuperview().inset(35)
		}
		
		currenceView.snp.makeConstraints { make in
			make.top.equalTo(condLabel.snp.bottom).offset(24)
			make.leading.trailing.equalToSuperview().inset(35)
			make.height.equalTo(30)
		}
		
		currencyTextField.snp.makeConstraints { make in
			make.leading.equalToSuperview().offset(18)
			make.centerY.equalToSuperview()
			make.height.equalTo(30)
		}
		
		verticalImageView.snp.makeConstraints { make in
			make.trailing.equalTo(currencyLabel.snp.leading).offset(-15)
			make.top.bottom.equalToSuperview()
		}
		
		currencyLabel.snp.makeConstraints { make in
			make.centerY.equalToSuperview()
			make.trailing.equalTo(pickerShowbutton.snp.leading).offset(-8)
		}
		
		picker.snp.makeConstraints { make in
			make.top.equalTo(currenceView.snp.bottom).offset(20)
			make.leading.trailing.equalToSuperview().inset(45)
		}
		
		pickerShowbutton.snp.makeConstraints { make in
			make.centerY.equalToSuperview()
			make.trailing.equalToSuperview().offset(-18)
		}
		
		button.snp.makeConstraints { make in
			make.height.equalTo(35)
			make.leading.trailing.equalToSuperview().inset(74)
			make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-62)
		}
	}
}

extension CreateNewGameViewController: UIPickerViewDataSource, UIPickerViewDelegate
{
	func numberOfComponents(in pickerView: UIPickerView) -> Int {
		1
	}
	
	func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
		return pickerElements.count
	}
	
	func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
		let row = pickerElements[row]
		return row
	}
}

extension CreateNewGameViewController: UITextFieldDelegate {
	
	//func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
		

//		if textField == currencyTextField {
//			if currencyTextField.text != "" {
//				button.isEnabled = true
//				currenceView.layer.borderWidth = 1
//				currenceView.layer.borderColor = UIColor.clear.cgColor
//				currencyLabel.textColor = #colorLiteral(red: 0.5921568627, green: 0.5921568627, blue: 0.5921568627, alpha: 1)
//				verticalImageView.image = UIImage(named: "vertical")
//				pickerShowbutton.tintColor = #colorLiteral(red: 0.5921568627, green: 0.5921568627, blue: 0.5921568627, alpha: 1)
//				currencyTextField.attributedPlaceholder = NSAttributedString(
//						string: "Укажите максимальную стоимость подарка",
//						attributes: [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.5921568627, green: 0.5921568627, blue: 0.5921568627, alpha: 1), NSAttributedString.Key.font : UIFont(name: "DMSans-Medium", size: 10)!]
//				)
//				return true
//			} else {
//				currenceView.layer.borderWidth = 1
//				currenceView.layer.borderColor = UIColor.red.cgColor
//				currencyLabel.textColor = .red
//				verticalImageView.image = UIImage(named: "red_line")
//				pickerShowbutton.tintColor = .red
//				currencyTextField.attributedPlaceholder = NSAttributedString(
//						string: "Укажите максимальную стоимость подарка",
//						attributes: [NSAttributedString.Key.foregroundColor: UIColor.red, NSAttributedString.Key.font : UIFont(name: "DMSans-Medium", size: 10)!]
//				)
//				button.isEnabled = false
//				return false
//			}
//		}
//		if textField == nameTextField {
//			if currencyTextField.text != "" {
//				button.isEnabled = true
//				randomLabel.isHidden = true
//			} else {
//				randomLabel.isHidden = false
//			}
//		}
//		return false
//	}
	
	func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
		let text = (nameTextField.text! as NSString).replacingCharacters(in: range, with: string)

	if text.isEmpty {
	 button.isEnabled = false
	 button.alpha = 0.5
	 randomLabel.isHidden = true
	} else {
	 button.isEnabled = true
	 button.alpha = 1.0
	 randomLabel.isHidden = false
	}
	
//		if text2.isEmpty /*&& currenceView.isHidden == false && picker.isHidden == false*/
//		{
//			button.isEnabled = false
//			button.alpha = 0.5
//			currenceView.layer.borderWidth = 1
//			currenceView.layer.borderColor = UIColor.red.cgColor
//			currencyLabel.textColor = .red
//			verticalImageView.image = UIImage(named: "red_line")
//			pickerShowbutton.tintColor = .red
//			currencyTextField.attributedPlaceholder = NSAttributedString(
//				string: "Укажите максимальную стоимость подарка",
//				attributes: [NSAttributedString.Key.foregroundColor: UIColor.red, NSAttributedString.Key.font : UIFont(name: "DMSans-Medium", size: 10)!]
//			)
//		} else {
//			button.isEnabled = true
//			button.alpha = 1.0
//			currenceView.layer.borderWidth = 1
//			currenceView.layer.borderColor = UIColor.clear.cgColor
//			currencyLabel.textColor = #colorLiteral(red: 0.5921568627, green: 0.5921568627, blue: 0.5921568627, alpha: 1)
//			verticalImageView.image = UIImage(named: "vertical")
//			pickerShowbutton.tintColor = #colorLiteral(red: 0.5921568627, green: 0.5921568627, blue: 0.5921568627, alpha: 1)
//			currencyTextField.attributedPlaceholder = NSAttributedString(
//				string: "Укажите максимальную стоимость подарка",
//				attributes: [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.5921568627, green: 0.5921568627, blue: 0.5921568627, alpha: 1), NSAttributedString.Key.font : UIFont(name: "DMSans-Medium", size: 10)!]
//				)
//		}
	 return true
	}
}

extension UIViewController {
	func hideKeyboardWhenTappedAround() {
		let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
		tap.cancelsTouchesInView = false
		view.addGestureRecognizer(tap)
	}
	
	@objc func dismissKeyboard() {
		view.endEditing(true)
	}
}
