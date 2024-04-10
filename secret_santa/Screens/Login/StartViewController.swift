//
//  ViewController.swift
//  secret_santa
//
//  Created by Mariya Aliyeva on 05.04.2024.
//

import UIKit
import SnapKit

final class StartViewController: BaseViewController {
	
	// MARK: - UI
	
	private lazy var santaView: SantaView = {
		let view = SantaView()
		view.configure(image: UIImage(named: "santa")!,
									 title: "Secret_Santa".localized,
									 subTitle: "Организуй тайный обмен подарками между друзьями или коллегами")
		return view
	}()
	
	private lazy var button: CustomButton = {
		let button = CustomButton(type: .system)
		button.configure(font: UIFont(name: "DMSans-Bold", size: 15) ?? .boldSystemFont(ofSize: 15))
		button.titleText = "Зарегистрироваться"
		button.addTarget(self, action: #selector(registTap), for: .touchUpInside)
		return button
	}()
	
	// MARK: - Lifecycle
	
	override func viewDidLoad() {
		super.viewDidLoad()
		setupViews()
		setupConstraints()
	}
	
	override func setupTitles() {
		
	}
	
	// MARK: - Button action
	
	@objc
	func registTap() {
		let registrationVC = RegistrationViewController()
		navigationController?.pushViewController(registrationVC, animated: true)
	}
	
	// MARK: - SetupViews
	
	private func setupViews() {
		navigationItem.setBackBarItem()
		navigationItem.backBarButtonItem?.tintColor = .black
		view.backgroundColor = #colorLiteral(red: 0.7538307309, green: 0.8903734088, blue: 0.8967731595, alpha: 1)
		[santaView, button].forEach {
			view.addSubview($0)
		}
	}
	
	// MARK: - SetupConstraints
	
	private func setupConstraints() {
		
		santaView.snp.makeConstraints { make in
			make.top.equalTo(view.safeAreaLayoutGuide).offset(80)
			make.leading.trailing.equalToSuperview()
		}
		
		button.snp.makeConstraints { make in
			make.height.equalTo(35)
			make.leading.trailing.equalToSuperview().inset(74)
			make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-72)
		}
	}
}

