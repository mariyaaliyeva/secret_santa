//
//  UpdateUserGeneralManager.swift
//  secret_santa
//
//  Created by Mariya Aliyeva on 10.04.2024.
//

import Foundation
import Moya

final class UpdateUserGeneralManager {
	
	static let shared = UpdateUserGeneralManager()
	private var authRepository: AuthRepositoryProtocol = AuthRepository()
	
	private let provider = MoyaProvider<UpdateUserGeneralTargetType>(
		plugins: [
			NetworkLoggerPlugin(configuration: NetworkLoggerPluginConfig.prettyLogging),
			LoggerPlugin()
		]
	)
	
	func updateUserInfo(name: String, email: String, image: Int,
		completion: @escaping ((APIResult<User>) -> ())
	){
		
		provider.request(.updateGeneral(name: name, email: email, imageId: image)) { result in
			switch result {
			case .success(let response):
				guard let user = try? JSONDecoder().decode(User.self, from: response.data) else {	completion(.failure(.incorrectJson))
					return }
				completion(.success(user))
			case .failure(_):
				completion(.failure(.unknown))
			}
		}
	}
	
	func updateUserPassword(
		email: String, password: String,
		completion: @escaping ((APIResult<(Void)>) -> ())
	){
		provider.request(.updatePassword(email: email, password: password)) { result in
			switch result {
			case .success(_):
				completion(.success(()))
			case .failure(let error):
				completion(.failure(.failedWith(error: error.localizedDescription)))
			}
		}
	}
}
