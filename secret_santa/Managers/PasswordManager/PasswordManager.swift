//
//  PasswordManager.swift
//  secret_santa
//
//  Created by Mariya Aliyeva on 09.04.2024.
//

import Foundation
import Moya

final class PasswordManager {
	
	static let shared = PasswordManager()
	private var authRepository: AuthRepositoryProtocol = AuthRepository()
	
	private let provider = MoyaProvider<PasswordTargetType>(
		plugins: [
			NetworkLoggerPlugin(configuration: NetworkLoggerPluginConfig.prettyLogging),
			LoggerPlugin()
		]
	)
	
	func recoveryPassword(
		email: String,
		completion: @escaping ((APIResult<(Void)>) -> ())
	){
		provider.request(.passwordRecovery(email: email)) { result in
			switch result {
			case .success(_):
				completion(.success(()))
			case .failure(let error):
				completion(.failure(.failedWith(error: error.localizedDescription)))
			}
		}
	}
}
