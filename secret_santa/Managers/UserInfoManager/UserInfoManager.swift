//
//  UserInfoManager.swift
//  secret_santa
//
//  Created by Mariya Aliyeva on 10.04.2024.
//

import Foundation
import Moya

final class UserInfoManager {
	
	static let shared = UserInfoManager()
	private var authRepository: AuthRepositoryProtocol = AuthRepository()
	
	private let provider = MoyaProvider<UserInfoTargetType>(
		plugins: [
			NetworkLoggerPlugin(configuration: NetworkLoggerPluginConfig.prettyLogging),
			LoggerPlugin()
		]
	)
	
	func getUserInfo(
		completion: @escaping ((APIResult<User>) -> ())
	){
		
		provider.request(.getUserInfo) { result in
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
}
