//
//  UpdateUserGeneralTargetType.swift
//  secret_santa
//
//  Created by Mariya Aliyeva on 10.04.2024.
//

import Foundation
import Moya

enum UpdateUserGeneralTargetType {
	case updateGeneral(name: String, email: String, imageId: Int)
	case updatePassword(email: String, password: String)
}

extension UpdateUserGeneralTargetType: BaseTargetType {
	
	var path: String {
		switch self {
		case .updateGeneral:
			return "/users/update/general"
		case .updatePassword:
			return "/users/update/password"
		}
	}
	
	var method: Moya.Method {
		return .put
	}
	
	var task: Moya.Task {
		switch self {
			
		case .updateGeneral(let name, let email, let imageId):
			return .requestParameters(
				parameters: [
					"fullName": name,
					"email": email,
					"imageId": imageId,
				],
				encoding: JSONEncoding.default
			)
			
		case .updatePassword(let email, let password):
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
			guard let token = AuthManager.shared.accessToken else {
				return [:]
			}
			headers["Authorization"] = "Bearer \(token)"
			return headers
		}
	}
