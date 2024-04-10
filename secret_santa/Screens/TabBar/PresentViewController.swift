//
//  PresentViewController.swift
//  secret_santa
//
//  Created by Mariya Aliyeva on 06.04.2024.
//

import UIKit

final class PresentViewController: UIViewController {
	
	// MARK: - UI
	
	private lazy var titleLabel = {
		let label = UILabel()
		label.textAlignment = .center
		label.font = UIFont(name: "DMSans-Bold", size: 25)
		label.text = "Мои игры"
		label.textColor = #colorLiteral(red: 1, green: 0.3882352941, blue: 0, alpha: 1)
		return label
	}()
	
	private lazy var santaImageView = {
		let image = UIImageView()
		image.contentMode = .scaleAspectFit
		image.image = UIImage(named: "santa3")
		return image
	}()
	
	private var subtitleLabel: UILabel = {
		let label = UILabel()
		label.text = "Пока что Вы не участвуете в играх"
		label.font = UIFont(name: "DMSans-Bold", size: 15)
		label.textAlignment = .center
		return label
	}()
	
	private var createLabel: UILabel = {
		let label = UILabel()
		label.text = "Создайте или вступите в игру, чтоб принять участие"
		label.font = UIFont(name: "DMSans-Regular", size: 10)
		label.textAlignment = .center
		return label
	}()
	
	private lazy var button: CustomButton = {
		let button = CustomButton(type: .system)
		button.configure(font: UIFont(name: "DMSans-Bold", size: 15) ?? .boldSystemFont(ofSize: 15))
		button.titleText = "Создать игру"
		button.addTarget(self, action: #selector(createGameTap), for: .touchUpInside)
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
		print("Error!")
	}
	
	@objc
	func createGameTap() {
		let controller = CreateNewGameViewController()
		navigationController?.pushViewController(controller, animated: true)
	}
	
	// MARK: - SetupViews
	
	private func setupViews() {
		navigationItem.setBackBarItem()
		navigationItem.backBarButtonItem?.tintColor = .black
		view.backgroundColor = #colorLiteral(red: 0.7538307309, green: 0.8903734088, blue: 0.8967731595, alpha: 1)
		[titleLabel,
		 santaImageView,
		 subtitleLabel,
		 createLabel,
		 button
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
		
		santaImageView.snp.makeConstraints { make in
			make.top.equalTo(titleLabel.snp.bottom).offset(30)
			make.centerX.equalToSuperview()
			make.size.equalTo(300)
		}
		
		subtitleLabel.snp.makeConstraints { make in
			make.top.equalTo(santaImageView.snp.bottom).offset(20)
			make.leading.trailing.equalToSuperview().inset(35)
		}
		createLabel.snp.makeConstraints { make in
			make.top.equalTo(subtitleLabel.snp.bottom).offset(8)
			make.leading.trailing.equalToSuperview().inset(35)
		}
		
		button.snp.makeConstraints { make in
			make.top.equalTo(createLabel.snp.bottom).offset(74)
			make.leading.trailing.equalToSuperview().inset(75)
		}
	}
}
