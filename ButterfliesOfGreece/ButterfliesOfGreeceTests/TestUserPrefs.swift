//
//  TestUserPrefs.swift
//  ButterfliesOfGreeceTests
//
//  Created by Ioannis Kapsouras on 14/8/20.
//  Copyright © 2020 Ioannis Kapsouras. All rights reserved.
//

import Foundation
import RxSwift

@testable import ButterfliesOfGreece

class MockUserDefaults:UserDefaults{
	var photos:[ButterflyPhoto]
	
	convenience init(numberOfPhotos:Int)
	{
		self.init(suiteName: "Mock User Defaults")!
		self.photos = [ButterflyPhoto]()
		if numberOfPhotos > 0{
			for _ in 1...numberOfPhotos {
				self.photos.append(ButterflyPhoto())
			}
		}
	}
	
	override init?(suiteName suitename: String?) {
		self.photos = [ButterflyPhoto]()
		UserDefaults().removePersistentDomain(forName: suitename!)
		super.init(suiteName: suitename)
	}
}

class MockCacheManager:CacheManagerProtocol{
	func delete(photo: ButterflyPhoto) -> Observable<[ButterflyPhoto]> {
		return Observable.from(optional: [ButterflyPhoto]())
	}
	
	var photosToPrint: String = "photosToPrint"
	var _prefs: UserDefaults
	
	init(userDefaults: UserDefaults)
	{
		_prefs = userDefaults
	}
	
	func savePhotosToPrint(photos: [ButterflyPhoto]) -> Observable<Bool> {
		(_prefs as! MockUserDefaults).photos = photos
		return Observable.from(optional: true)
	}
	
	func getPhotosToPrint() -> Observable<[ButterflyPhoto]> {
		return Observable.from(optional: (_prefs as! MockUserDefaults).photos)
	}
	
	func Clear() -> Observable<Bool> {
		return Observable.from(optional: true)
	}
	
	
}
