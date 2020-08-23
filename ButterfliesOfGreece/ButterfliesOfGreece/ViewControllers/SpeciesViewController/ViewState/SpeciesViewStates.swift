//
//  SpeciesViewStates.swift
//  ButterfliesOfGreece
//
//  Created by Apprecot on 19/8/20.
//  Copyright © 2020 Ioannis Kapsouras. All rights reserved.
//

import Foundation

enum SpeciesViewStates:ViewState{
	case SwitchViewStyle(currentArrange:ViewArrange)
	case ToPhotos
	case ShowSpecies(species:[Specie])
	
	var isTransition: Bool{
		switch self {
			case .ToPhotos:
				return true
			case .SwitchViewStyle,
				 .ShowSpecies:
				return false
		}
	}	
}

extension SpeciesViewStates{
	var toStoryboardName:String?{
		switch self {
		case .ToPhotos:
			return "Photos"
		default:
			return nil
		}
	}
	
	var toViewControllerName:String?{
		switch self {
		case .ToPhotos:
			return "PhotosViewController"
		default:
			return nil
		}
	}
}
