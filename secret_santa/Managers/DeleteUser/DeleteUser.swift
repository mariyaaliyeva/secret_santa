//
//  DeleteUser.swift
//  secret_santa
//
//  Created by Mariya Aliyeva on 10.04.2024.
//

import Foundation
import Moya

final class DeleteUser {
	
	static let shared = DeleteUser()
	private var authRepository: AuthRepositoryProtocol = AuthRepository()
	
	private let provider = MoyaProvider<DeleteUsersTargetType>(
		plugins: [
			NetworkLoggerPlugin(configuration: NetworkLoggerPluginConfig.prettyLogging),
			LoggerPlugin()
		]
	)
	
	func deleteUser(
		completion: @escaping ((APIResult<(Void)>) -> ())
	){
		provider.request(.deleteUser) { result in
			switch result {
			case .success(_):
				completion(.success(()))
			case .failure(let error):
				completion(.failure(.failedWith(error: error.localizedDescription)))
			}
		}
	}
}
