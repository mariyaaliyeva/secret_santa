//
//  DeleteUsers.swift
//  secret_santa
//
//  Created by Mariya Aliyeva on 10.04.2024.
//

import Foundation
import Moya

enum  DeleteUsersTargetType {
	case deleteUser
}

extension DeleteUsersTargetType: BaseTargetType {
	
	var path: String {
		switch self {
		case .deleteUser:
			return "/users"
		}
	}
	
	var method: Moya.Method {
		return .delete
	}
	
	var task: Moya.Task {
		switch self {
		case .deleteUser:
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
