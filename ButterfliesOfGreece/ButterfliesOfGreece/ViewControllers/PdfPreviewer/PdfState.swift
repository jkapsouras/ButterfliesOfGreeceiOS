//
//  PdfState.swift
//  ButterfliesOfGreece
//
//  Created by Ioannis Kapsouras on 16/9/20.
//  Copyright © 2020 Ioannis Kapsouras. All rights reserved.
//

import Foundation

struct PdfPreviewState {
	var pdfData: Data?
	var photos: [ButterflyPhoto]
	var pdfArrange: PdfArrange
	
	init(pdfData: Data?, photos:[ButterflyPhoto], pdfArrange:PdfArrange){
		self.pdfData = pdfData
		self.photos = photos
		self.pdfArrange = pdfArrange
	}
}

extension PdfPreviewState{
	func with(pdfData: Data? = nil, photos: [ButterflyPhoto]? = nil, pdfArrange:PdfArrange? = nil) -> PdfPreviewState{
		return PdfPreviewState(pdfData: pdfData ?? self.pdfData, photos: photos ?? self.photos, pdfArrange: pdfArrange ?? self.pdfArrange
		)
	}
}
