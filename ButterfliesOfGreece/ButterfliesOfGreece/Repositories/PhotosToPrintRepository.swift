//
//  PhotosToPrintRepository.swift
//  ButterfliesOfGreece
//
//  Created by Ioannis Kapsouras on 15/8/20.
//  Copyright © 2020 Ioannis Kapsouras. All rights reserved.
//

import Foundation
import RxSwift

struct PhotosToPrintRepository {
	let cacheManager:CacheManagerProtocol
	var storage:Storage
	
	init(cacheManager:CacheManagerProtocol, storage:Storage){
		self.cacheManager = cacheManager
		self.storage = storage
	}
	
	mutating func getPhotosToPrint() -> Observable<[ButterflyPhoto]>{
		return cacheManager.getPhotosToPrint()
	}
	
	func savePhotosToPrint(photos:[ButterflyPhoto]){
		_ = cacheManager.savePhotosToPrint(photos: photos)
	}
	
	func delete(photo:ButterflyPhoto) -> Observable<[ButterflyPhoto]>{
		return cacheManager.delete(photo: photo)
	}
	
	func deleteAll() -> Observable<Bool>{
		return cacheManager.Clear()
	}
}
