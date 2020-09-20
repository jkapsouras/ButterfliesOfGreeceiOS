//
//  MenuViewStates.swift
//  ButterfliesOfGreece
//
//  Created by Ioannis Kapsouras on 27/7/20.
//  Copyright © 2020 Ioannis Kapsouras. All rights reserved.
//

import Foundation

enum MenuViewState:ViewState {
	case toField
	case toIntroduction
	case toEndangered
	case toLegal
	case toAbout
	case toContribute
	case toOnlineRecognition
	case toOfflineRecognition
	
	var isTransition:Bool{
		switch self {
			case .toField,
			 .toIntroduction,
			 .toEndangered,
			 .toLegal,
			 .toAbout,
			 .toContribute,
			 .toOnlineRecognition,
			 .toOfflineRecognition:
				return true
		}
	}
}

extension MenuViewState{
	var toStoryboardName:String?{
		switch self {
		case .toField:
			return "Families"
		case .toContribute:
			return "Contribute"
		case .toAbout:
			return "About"
		default:
			return nil
		}
	}
	
	var toViewControllerName:String?{
		switch self {
		case .toField:
			return "FamiliesViewController"
		case .toContribute:
			return "ContributeViewController"
		case .toAbout:
			return "AboutViewController"
		default:
			return nil
		}
	}
}
