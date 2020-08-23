//
//  PhotosState.swift
//  ButterfliesOfGreece
//
//  Created by Ioannis Kapsouras on 23/8/20.
//  Copyright © 2020 Ioannis Kapsouras. All rights reserved.
//

import Foundation

struct PhotosState {
	let photos:[ButterflyPhoto]
	
	init(photos:[ButterflyPhoto]){
		self.photos = photos
	}
}

extension PhotosState{
	func with(photos:[ButterflyPhoto]? = nil) -> PhotosState{
		return PhotosState(photos: photos ?? self.photos)
	}
}
