//
//  ApiError.swift
//  ButterfliesOfGreece
//
//  Created by Apprecot on 25/9/20.
//  Copyright © 2020 Ioannis Kapsouras. All rights reserved.
//

import Foundation

public enum ApiError: Error {
	case forbidden              //Status code 403
	case notFound               //Status code 404
	case notAllowed
	case conflict               //Status code 409
	case internalServerError    //Status code 500
}

extension ApiError: LocalizedError {
	public var errorDescription: String? {
		switch self {
			case .forbidden:
				return Translations.Forbidden
			case .notFound:
				return Translations.NotFound
			case .notAllowed:
				return Translations.NotAllowed
			case .conflict:
				return Translations.Conflict
			case .internalServerError:
				return Translations.InternalServer
		}
	}
	
	public var errorForUser: String{
		return Translations.ErrorInRequest
	}
}
