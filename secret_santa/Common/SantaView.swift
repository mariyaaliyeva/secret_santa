//
//  StartSantaView.swift
//  secret_santa
//
//  Created by Mariya Aliyeva on 05.04.2024.
//

import UIKit

class SantaView: UIView {
	
	// MARK: - UI
	
	private lazy var stackView = {
		let stackView = UIStackView()
		stackView.axis = .vertical
		stackView.spacing = 27
		stackView.alignment = .center
		return stackView
	}()
	
	private lazy var textStackView = {
		let stackView = UIStackView()
		stackView.axis = .vertical
		stackView.spacing = 18
		stackView.alignment = .center
		return stackView
	}()
	
	private lazy var santaImageView = {
		let image = UIImageView()
		image.contentMode = .scaleAspectFit
		return image
	}()
	
	private lazy var titleLabel = {
		let label = UILabel()
		label.textAlignment = .center
		label.font = UIFont(name: "DMSans-Bold", size: 40)
		return label
	}()
	
	private lazy var subTitleLabel = {
		let label = UILabel()
		label.numberOfLines = 0
		label.textAlignment = .center
		label.font = UIFont(name: "DMSans-Regular", size: 10)
		return label
	}()
	
	// MARK: - Init
	
	init() {
		super.init(frame: .zero)
		setupViews()
		setupConstraints()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	// MARK: - Public
	
	func configure(image: UIImage, title: String, subTitle: String) {
		let titleParagraphStyle = NSMutableParagraphStyle()
		titleParagraphStyle.lineSpacing = 10
		titleParagraphStyle.alignment = .center
		let attriString = NSAttributedString(string: subTitle, attributes:
																					[ NSAttributedString.Key.paragraphStyle: titleParagraphStyle])
		subTitleLabel.attributedText = attriString
		santaImageView.image = image
		titleLabel.text = title
	}
	
	// MARK: - SetupViews
	
	private func setupViews() {
		backgroundColor = #colorLiteral(red: 0.7538307309, green: 0.8903734088, blue: 0.8967731595, alpha: 1)
		addSubview(stackView)
		
		[titleLabel, 
		 subTitleLabel].forEach { 
			textStackView.addArrangedSubview($0)
		}
		
		[santaImageView,
		 textStackView].forEach {
			stackView.addArrangedSubview($0)
		}
	}
	
	// MARK: - SetupConstraints
	
	private func setupConstraints() {
		
		stackView.snp.makeConstraints { make in
			make.top.equalToSuperview().offset(64)
			make.leading.trailing.equalToSuperview().inset(36)
		}
		
		santaImageView.snp.makeConstraints { make in
			make.size.equalTo(300)
		}
		
		subTitleLabel.snp.makeConstraints { make in
			make.leading.trailing.equalToSuperview().inset(44)
		}
	}
}
