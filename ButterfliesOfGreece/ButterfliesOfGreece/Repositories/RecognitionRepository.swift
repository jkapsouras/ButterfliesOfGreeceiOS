//
//  RecognitionRepository.swift
//  ButterfliesOfGreece
//
//  Created by Apprecot on 25/9/20.
//  Copyright © 2020 Ioannis Kapsouras. All rights reserved.
//

import Foundation
import RxSwift

struct RecognitionRepository {
	var api:ApiClient
	
	init(api:ApiClient){
		self.api = api
	}
	
	func recognize(image:Avatar) -> Observable<Predictions>{
		return api.Analyze(image: image)
	}
}
