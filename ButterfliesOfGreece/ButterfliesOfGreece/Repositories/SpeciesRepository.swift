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
	
	mutating func getAllSpecies() -> Observable<[Specie]>{
		return Observable.from(optional: storage.species())
	}
	
	mutating func getSpeciesOfFamily(familyId:Int) -> Observable<[Specie]>{
		return Observable.from(optional: storage.species(familyId: familyId))
	}
	
	mutating func getSelectedFamilyName(familyId:Int) -> Observable<String>{
		return Observable.from(optional: storage.getSelectedFamilyName(familyId: familyId))
	}
	
	mutating func getSpeciesFromSearchTerm(term:String) -> Observable<[Specie]>{
		return Observable.from(optional:
			storage.searchSpeciesBy(term: term))
	}
}
