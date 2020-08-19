//
//  CacheManager.swift
//  ButterfliesOfGreece
//
//  Created by Ioannis Kapsouras on 14/8/20.
//  Copyright © 2020 Ioannis Kapsouras. All rights reserved.
//

import Foundation
import RxSwift

protocol CacheManagerProtocol
{
	var photosToPrint:String { get }
	var _prefs:UserDefaults { get }

	func  savePhotosToPrint(photos:[ButterflyPhoto]) -> Observable<Bool>
	func  getPhotosToPrint() -> Observable<[ButterflyPhoto]>
	func  Clear() -> Observable<Bool>
}

struct CacheManager:CacheManagerProtocol
{
	var photosToPrint: String = "photosToPrint"
	var _prefs: UserDefaults
	
	init(userDefaults: UserDefaults)
	{
		_prefs = userDefaults
	}
	
	func savePhotosToPrint(photos:[ButterflyPhoto]) -> Observable<Bool> {
		do{
		let encodedData = try NSKeyedArchiver.archivedData(withRootObject: photos, requiringSecureCoding: false)
		return Observable.from(optional: UserDefaults.standard.set(encodedData, forKey: photosToPrint)).do(onNext:{self._prefs.synchronize()}).map({ _ in return true})
		}
		catch{
			 print("Unexpected error: \(error).")
			return Observable.from(optional: false)
		}
	}
	
	func getPhotosToPrint() -> Observable<[ButterflyPhoto]> {
		let decoded = _prefs.data(forKey: photosToPrint)
		guard let decodedF = decoded else{
			return Observable.from(optional: [ButterflyPhoto]())
		}
		let decodedPhotos = try! NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(decodedF)
		var tempPhotos = decodedPhotos as? [ButterflyPhoto]
		if tempPhotos == nil{
			tempPhotos = [ButterflyPhoto]()
		}
		return Observable.from(optional:  tempPhotos)
	}
	
	func Clear() -> Observable<Bool> {
		_prefs.removeObject(forKey: photosToPrint)
		return Observable.from(optional: true);
	}
}
