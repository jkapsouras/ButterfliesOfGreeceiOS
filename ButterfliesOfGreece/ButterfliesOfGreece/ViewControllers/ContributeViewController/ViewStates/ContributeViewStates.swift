//
//  ContributeViewStates.swift
//  ButterfliesOfGreece
//
//  Created by Ioannis Kapsouras on 18/9/20.
//  Copyright © 2020 Ioannis Kapsouras. All rights reserved.
//

import Foundation

enum ContributeViewStates:ViewState{
	case showDatePicker
	case hideDatePicker
	case setDate(date:String)
	case showSettingsDialog
	case showLocation(latitude:String, longitude:String)
	case showLocationError
	case showItemAdded
	case showItemNotAdded
	case showExtractedPdf(pdfData: Data)
	case showShareDialog(pdfData: Data)
	case showInstructions
	case closePdf
	
	var isTransition: Bool{
		switch self {
		case .showInstructions:
			return true
		default:
			return false
		}
	}
}

extension ContributeViewStates{
	var toStoryboardName:String?{
		switch self {
		case .showInstructions:
			return "InfoModal"
		default:
			return nil
		}
	}
	
	var toViewControllerName:String?{
		switch self {
		case .showInstructions:
			return "InfoModalViewController"
		default:
			return nil
		}
	}
}
