//
//  FamiliesViewStates.swift
//  ButterfliesOfGreece
//
//  Created by Ioannis Kapsouras on 27/7/20.
//  Copyright © 2020 Ioannis Kapsouras. All rights reserved.
//

import Foundation

enum FamiliesViewStates:ViewState{
	case SwitchViewStyle(currentArrange:ViewArrange)
	case ToSpecies
	case ShowFamilies(families:[Family])
	
	var isTransition: Bool{
		switch self {
		case .ToSpecies:
			return true
		case .SwitchViewStyle,
			 .ShowFamilies:
			return false
		}
	}
}
