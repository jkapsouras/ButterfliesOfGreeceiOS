//
//  SpeciesRepository.swift
//  ButterfliesOfGreece
//
//  Created by Apprecot on 19/8/20.
//  Copyright © 2020 Ioannis Kapsouras. All rights reserved.
//

import Foundation
import RxSwift

struct SpeciesRepository {
	var storage:Storage
	
	init(storage:Storage){
		self.storage = storage
	}
	
	mutating func getSpeciesOfFamily(familyId:Int) -> Observable<[Specie]>{
		return Observable.from(optional: storage.species(familyId: familyId))
	}
}
