//
//  ContributionRepository.swift
//  ButterfliesOfGreece
//
//  Created by Ioannis Kapsouras on 19/9/20.
//  Copyright © 2020 Ioannis Kapsouras. All rights reserved.
//

import Foundation
import RxSwift

struct ContributionRepository {
	let cacheManager:CacheManagerProtocol
	
	init(cacheManager:CacheManagerProtocol){
		self.cacheManager = cacheManager
	}
	
	func getContributionItems() -> Observable<[ContributionItem]>{
		return cacheManager.getContributionItems()
	}
	
	func saveContributionItem(item:ContributionItem) -> Observable<Bool>{
		return cacheManager.saveContributionItem(item: item)
	}
	
	func delete() -> Observable<Bool>{
		return cacheManager.deleteContributionItems()
	}
}
