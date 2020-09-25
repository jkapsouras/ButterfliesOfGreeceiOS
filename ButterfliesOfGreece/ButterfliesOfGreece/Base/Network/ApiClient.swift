//
//  ApiClient.swift
//  ButterfliesOfGreece
//
//  Created by Ioannis Kapsouras on 23/9/20.
//  Copyright © 2020 Ioannis Kapsouras. All rights reserved.
//

import Foundation
import Alamofire
import RxSwift

protocol ApiClientProtocol
{
	func Analyze(image:Avatar) -> Observable<Predictions>
}

class ApiClient : ApiClientProtocol{
	let BaseAddress:String
	
	init(baseAddress:String)
	{
		BaseAddress=baseAddress
	}
	
	func Analyze(image:Avatar) -> Observable<Predictions>
	{
		return requestMultipart(ApiRouter.sendImage(image:image), try! ApiRouter.sendImage(image: image).asURL(), image:image.avatar)
	}
	
	//-------------------------------------------------------------------------------------------------
	//MARK: - The request function to get results in an Observable
	private func requestMultipart<T: Codable> (_ urlRequestConvertible: URLRequestConvertible, _ urlConvertible: URLConvertible, image:Data) -> Observable<T> {
		//Create an RxSwift observable, which will be the one to call the request when subscribed to
		return Observable<T>.create { observer in
			//Trigger the HttpRequest using AlamoFire (AF)
			print("url:\(String(describing: urlRequestConvertible.urlRequest?.url))")
			
			let requestMultpart = try! AF.upload(multipartFormData: { multipartFormData in
				multipartFormData.append(image, withName: "avatar", fileName: "avatar", mimeType: "image/jpeg")
			}, to: urlConvertible, method: .post, headers: urlRequestConvertible.asURLRequest().headers).responseDecodable(of: T.self){ response in
				//Check the result from Alamofire's response and check if it's a success or a failure
				let data = response.data.map{ String(decoding: $0, as: UTF8.self) } ?? "None"
				print(data)
				switch response.result {
					case .success(let value):
						//Everything is fine, return the value in onNext
						observer.onNext(value)
						observer.onCompleted()
					case .failure(let error):
						//Something went wrong, switch on the status code and return the error
						switch response.response?.statusCode {
							case 403:
								observer.onError(ApiError.forbidden)
							case 405:
								observer.onError(ApiError.notAllowed)
							case 404:
								observer.onError(ApiError.notFound)
							case 409:
								observer.onError(ApiError.conflict)
							case 500:
								observer.onError(ApiError.internalServerError)
							default:
								observer.onError(error)
						}
				}
			}
			
			//Finally, we return a disposable to stop the request
			return Disposables.create {
				requestMultpart.cancel()
			}
		}
	}
}
