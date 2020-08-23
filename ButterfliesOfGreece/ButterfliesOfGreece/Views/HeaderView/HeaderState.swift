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
	let headerName:String
	
	init(currentArrange:ViewArrange, photosToPrint:[ButterflyPhoto]?, headerName:String){
		self.currentArrange = currentArrange
		self.photosToPrint = photosToPrint
		self.headerName = headerName
	}
}

extension HeaderState{
	func with(arrange:ViewArrange? = nil, photos:[ButterflyPhoto]? = nil, headerName:String? = nil) -> HeaderState{
		
		guard let photos = photos else{
			return HeaderState(
				currentArrange: arrange ?? self.currentArrange,
				photosToPrint: self.photosToPrint,
				headerName: headerName ?? self.headerName
			)
		}
		
		guard let statePhotos = self.photosToPrint else{
			return HeaderState(
				currentArrange: arrange ?? self.currentArrange,
				photosToPrint: photos,
				headerName: headerName ?? self.headerName
			)
		}
		
		let tmpPhotos = statePhotos + photos
		return HeaderState(
			currentArrange: arrange ?? self.currentArrange,
			photosToPrint: tmpPhotos.uniques,
			headerName: headerName ?? self.headerName)
	}
}
