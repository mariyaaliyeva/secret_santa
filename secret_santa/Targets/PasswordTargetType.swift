//
//  PasswordTargetType.swift
//  secret_santa
//
//  Created by Mariya Aliyeva on 09.04.2024.
//

import Foundation
import Moya

enum PasswordTargetType {
	case passwordRecovery(email: String)
}

extension PasswordTargetType: BaseTargetType {
	
	var path: String {
		switch self {
		case .passwordRecovery:
			return "/auth/password-recovery"
		}
	}
	
	var method: Moya.Method {
		return .post
	}
	
	var task: Moya.Task {
		switch self {
			
		case .passwordRecovery(email: let email):
			return .requestParameters(
				parameters: [
					"email": email
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

