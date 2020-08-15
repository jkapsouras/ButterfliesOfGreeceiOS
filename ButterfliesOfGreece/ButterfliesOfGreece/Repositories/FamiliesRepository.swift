//
//  FamiliesRepository.swift
//  ButterfliesOfGreece
//
//  Created by Ioannis Kapsouras on 15/8/20.
//  Copyright © 2020 Ioannis Kapsouras. All rights reserved.
//

import Foundation
import RxSwift

struct FamiliesRepository {
	var storage:Storage
	
	init(storage:Storage){
		self.storage = storage
	}
	
	mutating func getAllFamilies() -> Observable<[Family]>{
		return Observable.from(optional: storage.families)
	}
}
