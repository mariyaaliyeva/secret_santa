//
//  UserInfoTargetType.swift
//  secret_santa
//
//  Created by Mariya Aliyeva on 10.04.2024.
//

import Foundation
import Moya

enum UserInfoTargetType {
	case getUserInfo
}

extension UserInfoTargetType: BaseTargetType {
	
	var path: String {
		switch self {
		case .getUserInfo:
			return "/users"
		}
	}

	var task: Moya.Task {
		switch self {
		case .getUserInfo:
			return .requestPlain
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
