//
//  PhotosRepository.swift
//  ButterfliesOfGreece
//
//  Created by Ioannis Kapsouras on 23/8/20.
//  Copyright © 2020 Ioannis Kapsouras. All rights reserved.
//

import Foundation
import RxSwift

struct PhotosRepository {
	var storage:Storage
	
	init(storage:Storage){
		self.storage = storage
	}
	
	mutating func getPhotosOfSpecie(specieId:Int) -> Observable<[ButterflyPhoto]>{
		return Observable.from(optional: storage.photos(specieId: specieId))
	}
	
	mutating func getSelectedSpecieName(specieId:Int) -> Observable<String>{
		return Observable.from(optional: storage.getSelectedSpecieName(specieId: specieId))
	}
}
