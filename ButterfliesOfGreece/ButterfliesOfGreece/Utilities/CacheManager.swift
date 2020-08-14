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
		return Observable.from(optional: UserDefaults.standard.set(photos, forKey: photosToPrint)).map({ _ in return true})
	}
	
	func getPhotosToPrint() -> Observable<[ButterflyPhoto]> {
		let temp = UserDefaults.standard.array(forKey: photosToPrint)
		var tempPhotos = temp as? [ButterflyPhoto]
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
