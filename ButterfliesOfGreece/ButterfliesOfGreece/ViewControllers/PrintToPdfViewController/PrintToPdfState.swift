//
//  PrintToPdfState.swift
//  ButterfliesOfGreece
//
//  Created by Ioannis Kapsouras on 13/9/20.
//  Copyright © 2020 Ioannis Kapsouras. All rights reserved.
//

import Foundation

enum PdfArrange{
	case onePerPage
	case twoPerPage
	case fourPerPage
	case sixPerPage
	
	func toString() -> String{
		switch self {
		case .onePerPage:
			return "1"
		case .twoPerPage:
			return "2"
		case .fourPerPage:
			return "4"
		case .sixPerPage:
			return "6"
		}
	}
}

struct PhotosToPdfState {
let photos:[ButterflyPhoto]
	let pdfArrange:PdfArrange
	
	init(photos:[ButterflyPhoto], pdfArrange:PdfArrange){
		self.photos = photos
		self.pdfArrange = pdfArrange
	}
}

extension PhotosToPdfState{
	func with(photos:[ButterflyPhoto]? = nil, pdfArrange:PdfArrange? = nil) -> PhotosToPdfState{
		return PhotosToPdfState(photos: photos ?? self.photos,pdfArrange: pdfArrange ?? self.pdfArrange)
	}
}
