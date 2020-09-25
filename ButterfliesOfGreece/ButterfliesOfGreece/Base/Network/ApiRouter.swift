//
//  ApiRouter.swift
//  ButterfliesOfGreece
//
//  Created by Ioannis Kapsouras on 23/9/20.
//  Copyright © 2020 Ioannis Kapsouras. All rights reserved.
//

import Foundation
import Alamofire

enum ApiRouter: URLRequestConvertible {
	//The endpoint name we'll call later
	case sendImage(image:Avatar)
	
	func asURL() throws -> URLConvertible{
		let url = try Constants.Network.BaseAddress.asURL()
		let urlRequest = url.appendingPathComponent(path)
		return urlRequest
	}
	
	//MARK: - URLRequestConvertible
	func asURLRequest() throws -> URLRequest {
		let url = try Constants.Network.BaseAddress.asURL()
		var urlRequest = URLRequest(url: url.appendingPathComponent(path))
		//Http method
		urlRequest.httpMethod = method.rawValue
		// Common Headers
		urlRequest.setValue(Constants.Network.ContentType.json.rawValue, forHTTPHeaderField: Constants.Network.HttpHeaderField.acceptType.rawValue)
		urlRequest.setValue(Constants.Network.ContentType.multiPart.rawValue, forHTTPHeaderField: Constants.Network.HttpHeaderField.contentType.rawValue)
		
		//Encoding
		let encoding: ParameterEncoder = {
			switch method {
			case .post:
				return URLEncodedFormParameterEncoder.default
			default:
				return JSONParameterEncoder.default
			}
		}()
		
		return  try encoding.encode(parameters, into: urlRequest)
	}
	
	//MARK: - HttpMethod
	//This returns the HttpMethod type. It's used to determine the type if several endpoints are peresent
	private var method: HTTPMethod {
		return .post
	}
	
	//MARK: - Path
	//The path is the part following the base url
	private var path: String {
		switch self {
		case .sendImage:
			return "/analyze"
		}
	}
	
	private var headers:String?{
		switch self {
		default:
			return nil
		}
	}
	
	//MARK: - Parameters
	//This is the queries part, it's optional because an endpoint can be without parameters
	private var parameters:Avatar {
		switch self{
		case .sendImage(let image):
			return image
		}
	}
}
