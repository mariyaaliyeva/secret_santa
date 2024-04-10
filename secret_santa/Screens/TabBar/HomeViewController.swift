//
//  HomeViewController.swift
//  secret_santa
//
//  Created by Mariya Aliyeva on 06.04.2024.
//

import UIKit

final class HomeViewController: UIViewController {
	
	// MARK: - UI
	
	private lazy var santaView: SantaView = {
		let view = SantaView()
		view.configure(image: UIImage(named: "santa")!,
									 title: "Secret_Santa".localized,
									 subTitle: "Organize_a_secret_exchange_between_friends_or_colleagues".localized)
		return view
	}()
	
	private lazy var button: CustomButton = {
		let button = CustomButton(type: .system)
		button.configure(font: UIFont(name: "DMSans-Bold", size: 15) ?? .boldSystemFont(ofSize: 15))
		button.titleText = "Create_game".localized
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
	func createGameTap() {
		let controller = CreateNewGameViewController()
		navigationController?.pushViewController(controller, animated: true)
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
			make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
			make.leading.trailing.equalToSuperview()
		}
		
		button.snp.makeConstraints { make in
			make.height.equalTo(35)
			make.leading.trailing.equalToSuperview().inset(74)
			make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-62)
		}
	}
}
