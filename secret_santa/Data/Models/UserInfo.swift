//
//  UserInfo.swift
//  secret_santa
//
//  Created by Mariya Aliyeva on 10.04.2024.
//

import Foundation

// MARK: - User
struct User: Codable {
		let email: String?
		let imageID, fullName: String?

		enum CodingKeys: String, CodingKey {
				case email
				case imageID = "imageId"
				case fullName
		}
}

