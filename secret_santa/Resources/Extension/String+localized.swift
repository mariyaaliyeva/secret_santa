//
//  String+localized.swift
//  secret_santa
//
//  Created by Mariya Aliyeva on 10.04.2024.
//

import Foundation

extension String {
		var localized: String {
				NSLocalizedString(
						self,
						comment: "\(self) could not be found in Localizable.strings"
				)
		}
}
