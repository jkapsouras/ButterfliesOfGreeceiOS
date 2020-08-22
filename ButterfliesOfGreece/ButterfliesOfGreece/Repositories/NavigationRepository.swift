//
//  NavigationRepository.swift
//  ButterfliesOfGreece
//
//  Created by Ioannis Kapsouras on 22/8/20.
//  Copyright © 2020 Ioannis Kapsouras. All rights reserved.
//

import Foundation
import RxSwift

struct NavigationRepository {
	var storage:Storage
	
	init(storage:Storage){
		self.storage = storage
	}
	
	mutating func selectFamilyId(familyId:Int) -> Observable<Bool>{
		return storage.setFamilyId(familyId: familyId)
	}
	
	func getFamilyId() -> Observable<Int>{
		return storage.getFamilyId()
	}
	
	mutating func selectSpecieId(specieId:Int) -> Observable<Bool>{
		return storage.setSpecieId(specieId: specieId)
	}
	
	func getSpecieId() -> Observable<Int>{
		return storage.getSpecieId()
	}
	
	mutating func setViewArrange(arrange:ViewArrange) -> Observable<Bool>{
		return storage.setViewArrange(currentArrange:arrange)
	}
	
	mutating func changeViewArrange() -> Observable<ViewArrange>{
		storage.changeArrange()
		return Observable.from(optional: Storage.currentArrange)
	}
	
	func getViewArrange() -> Observable<ViewArrange>{
		return Observable.from(optional: Storage.currentArrange)
	}
}
