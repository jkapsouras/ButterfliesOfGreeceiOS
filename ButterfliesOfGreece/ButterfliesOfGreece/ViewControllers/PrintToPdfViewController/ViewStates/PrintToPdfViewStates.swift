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
	case arrangeViewChanged(currentArrange:PdfArrange)
	case allPhotosDeleted
	case toPrintPreview
	
	var isTransition: Bool{
		switch self {
		case .allPhotosDeleted,
			 .toPrintPreview:
			return true
		default:
			return false
		}
	}
}

extension PrintToPdfViewStates{
	var toStoryboardName:String?{
		switch self {
		case .allPhotosDeleted:
			return "Families"
		case .toPrintPreview:
			return "PdfPreview"
		default:
			return nil
		}
	}
	
	var toViewControllerName:String?{
		switch self {
		case .allPhotosDeleted:
			return "FamiliesViewController"
			case .toPrintPreview:
			return "PdfPreviewViewController"
		default:
			return nil
		}
	}
}
