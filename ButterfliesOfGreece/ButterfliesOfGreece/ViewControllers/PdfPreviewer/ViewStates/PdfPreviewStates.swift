//
//  PdfPreviewStates.swift
//  ButterfliesOfGreece
//
//  Created by Ioannis Kapsouras on 16/9/20.
//  Copyright © 2020 Ioannis Kapsouras. All rights reserved.
//

import Foundation

enum PdfPreviewViewStates:ViewState{
	case showPdf(pdfData: Data)
	case showShareDialog(pdfData: Data)
	
	var isTransition: Bool{
		return false
	}
}
