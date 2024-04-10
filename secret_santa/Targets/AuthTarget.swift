//
//  AuthTarget.swift
//  secret_santa
//
//  Created by Mariya Aliyeva on 09.04.2024.
//

import Foundation
import Moya

enum AuthTarget {
	case getAccessTokenWhenRegister(email: String, password: String)
	case getAccessTokenWhenLogin(email: String, password: String)
}

extension AuthTarget: BaseTargetType {
	
	var path: String {
		switch self {
			
		case .getAccessTokenWhenRegister:
			return "/auth/register"
		case .getAccessTokenWhenLogin:
			return "auth/authenticate"
		}
	}
	var method: Moya.Method {
		return .post
	}
	
	var task: Moya.Task {
		switch self {
			
		case .getAccessTokenWhenRegister(let email, let password):
			return .requestParameters(
				parameters: [
					"email": email,
					"password": password
				],
				encoding: JSONEncoding.default
			)
			
		case .getAccessTokenWhenLogin(let email, let password):
			return .requestParameters(
				parameters: [
					"email": email,
					"password": password
				],
				encoding: JSONEncoding.default
			)
		}
	}
	
	var headers: [String : String]? {
		var headers = [String : String]()
		headers["Content-Type"] = "application/json"
		return headers
	}
}
