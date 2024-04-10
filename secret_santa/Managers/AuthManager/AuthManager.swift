//
//  AuthManager.swift
//  secret_santa
//
//  Created by Mariya Aliyeva on 09.04.2024.
//

import Foundation
import SwiftKeychainWrapper
import Moya

final class AuthManager {
	
	static let shared = AuthManager()
	private var authRepository: AuthRepositoryProtocol = AuthRepository()
	
	private let provider = MoyaProvider<AuthTarget>(
		plugins: [
			NetworkLoggerPlugin(configuration: NetworkLoggerPluginConfig.prettyLogging),
			LoggerPlugin()
		]
	)
	
	var isSignedIn: Bool {
		return accessToken != nil
	}
	
	private init() {}
	
	var accessToken: String? {
		return authRepository.getAccessToken()
	}

	func exchangeCodeForToken(
		email: String,
		password: String,
		completion: @escaping ((APIResult<AuthResponse>) -> ())
	){
		
		provider.request(.getAccessTokenWhenRegister(email: email, password: password)) { [weak self] result in
			switch result {
			case .success(let response):
				print(response.data)
				guard let result = try? response.map(AuthResponse.self) else {
					completion(.failure(.incorrectJson))
					return
				}
				self?.cacheToken(result: result)
				completion(.success((result)))
			case .failure(let error):
				completion(.failure(.failedWith(error: error.localizedDescription)))
			}
		}
	}
	
	func getTokenWhenLogin(
		email: String,
		password: String,
		completion: @escaping ((APIResult<AuthResponse>) -> ())
	){
		
		provider.request(.getAccessTokenWhenLogin(email: email, password: password)) { [weak self] result in
			switch result {
			case .success(let response):
				print(response.data)
				guard let result = try? response.map(AuthResponse.self) else {
					completion(.failure(.incorrectJson))
					return
				}
				self?.cacheToken(result: result)
				completion(.success((result)))
			case .failure(let error):
				completion(.failure(.failedWith(error: error.localizedDescription)))
			}
		}
	}
	
	private func cacheToken(result: AuthResponse) {
		
		authRepository.save(accessToken: result.token)
	}
	
	func signOut(completion: (Bool) -> Void) {
		authRepository.removeAllTokens()
	}
}
