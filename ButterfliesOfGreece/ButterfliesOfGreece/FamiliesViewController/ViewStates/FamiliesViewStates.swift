//
//  FamiliesViewStates.swift
//  ButterfliesOfGreece
//
//  Created by Ioannis Kapsouras on 27/7/20.
//  Copyright © 2020 Ioannis Kapsouras. All rights reserved.
//

import Foundation

enum FamiliesViewStates:ViewState{
	case SwitchViewStyle(currentArrange:viewArrange)
	case ToSpecies(familyId:Int)
	
	var isTransition: Bool{
		switch self {
		case .ToSpecies:
			return true
		case .SwitchViewStyle:
			return false
		}
	}
	
}
