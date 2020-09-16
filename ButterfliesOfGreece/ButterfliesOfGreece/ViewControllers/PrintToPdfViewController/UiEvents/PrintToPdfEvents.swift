//
//  PrintToPdfEvents.swift
//  ButterfliesOfGreece
//
//  Created by Ioannis Kapsouras on 13/9/20.
//  Copyright © 2020 Ioannis Kapsouras. All rights reserved.
//

import Foundation

enum PrintToPdfEvents:UiEvent{
	case loadPhotos
	case changeArrangeClicked
	case arrangeSelected(pdfArrange:PdfArrange)
	case deleteAll
	case delete(photo:ButterflyPhoto)
	case printPhotos
}
