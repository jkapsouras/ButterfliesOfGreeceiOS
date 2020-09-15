//
//  PrintToPdfViewStates.swift
//  ButterfliesOfGreece
//
//  Created by Ioannis Kapsouras on 13/9/20.
//  Copyright © 2020 Ioannis Kapsouras. All rights reserved.
//

import Foundation

enum PrintToPdfViewStates:ViewState{
	case showPhotos(photos:[ButterflyPhoto])
	case showNumberOfPhotos(numberOfPhotos:Int)
	case showPickArrangeView(currentArrange:PdfArrange)
	
	var isTransition: Bool{
		return false
	}
}
