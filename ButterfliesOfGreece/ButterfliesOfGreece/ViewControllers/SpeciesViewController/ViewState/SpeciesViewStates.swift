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
	case ToPhotos(specieId:Int)
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
