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
	let indexOfSelectedPhoto:Int
	
	init(photos:[ButterflyPhoto], indexOfSelectedPhoto:Int){
		self.photos = photos
		self.indexOfSelectedPhoto = indexOfSelectedPhoto
	}
}

extension PhotosState{
	func with(photos:[ButterflyPhoto]? = nil, photoId:Int? = nil) -> PhotosState{
		let tmpPhotos = photos ?? self.photos
		let index = tmpPhotos.firstIndex(where: {$0.id == photoId ?? -1})
		return PhotosState(photos: photos ?? self.photos,indexOfSelectedPhoto: index ?? self.indexOfSelectedPhoto)
	}
}
