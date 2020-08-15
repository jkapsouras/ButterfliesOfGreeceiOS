//
//  HeaderState.swift
//  ButterfliesOfGreece
//
//  Created by Ioannis Kapsouras on 14/8/20.
//  Copyright © 2020 Ioannis Kapsouras. All rights reserved.
//

import Foundation

struct HeaderState {
	let photosToPrint:[ButterflyPhoto]?
	let currentArrange:ViewArrange
	
	init(arrange:ViewArrange, photos:[ButterflyPhoto]?){
		currentArrange = arrange
		photosToPrint = photos
	}
}

extension HeaderState{
	func with(arrange:ViewArrange? = nil, photos:[ButterflyPhoto]? = nil) -> HeaderState{
		return HeaderState(
			arrange: arrange ?? self.currentArrange,
			photos: photos ?? self.photosToPrint
		)
	}
}
