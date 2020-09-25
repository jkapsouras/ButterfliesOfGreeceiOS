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
		return request(ApiRouter.sendImage(image:image), image:image.avatar)
	}
	
	//-------------------------------------------------------------------------------------------------
	//MARK: - The request function to get results in an Observable
	private func request<T: Codable> (_ urlConvertible: URLRequestConvertible, image:Data) -> Observable<T> {
		//Create an RxSwift observable, which will be the one to call the request when subscribed to
		return Observable<T>.create { observer in
			//Trigger the HttpRequest using AlamoFire (AF)
//			print("url:\(urlConvertible.urlRequest?.url)")
			print("url:\(urlConvertible)")
//			urlConvertible.urlRequest?.allHTTPHeaderFields?.forEach({header in
//				print("header: \(header)")
//			})
			
			
			
			let request = try! AF.upload(image, to: urlConvertible.urlRequest?.url as! URLConvertible, method: urlConvertible.asURLRequest().method!, headers: urlConvertible.asURLRequest().headers, interceptor: nil, fileManager: FileManager(), requestModifier: nil).responseDecodable(of: T.self){ response in
				//Check the result from Alamofire's response and check if it's a success or a failure
				var data = response.data.map{ String(decoding: $0, as: UTF8.self) } ?? "None"
				print(data)
				var code = response.response?.statusCode
				switch response.result {
				case .success(let value):
					//Everything is fine, return the value in onNext
					observer.onNext(value)
					observer.onCompleted()
				case .failure(let error):
					//Something went wrong, switch on the status code and return the error
					print(response.response?.statusCode)
//					switch response.response?.statusCode {
//					case 403:
//						observer.onError(ApiError.forbidden)
//					case 404:
//						observer.onError(ApiError.notFound)
//					case 409:
//						observer.onError(ApiError.conflict)
//					case 500:
//						observer.onError(ApiError.internalServerError)
//					default:
//						observer.onError(error)
//					}
				}
			}
			
			//Finally, we return a disposable to stop the request
			return Disposables.create {
				request.cancel()
			}
		}
	}
}
