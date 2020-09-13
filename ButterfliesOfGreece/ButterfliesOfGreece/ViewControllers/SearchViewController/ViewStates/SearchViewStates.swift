//
//  SearchViewStates.swift
//  ButterfliesOfGreece
//
//  Created by Ioannis Kapsouras on 5/9/20.
//  Copyright © 2020 Ioannis Kapsouras. All rights reserved.
//

import Foundation

enum SearchViewStates:ViewState{
	case ShowResult(result:[Specie], fromSearch: Bool)
	case ToSpecie
	
	var isTransition: Bool{
		switch self {
			case .ToSpecie:
				return true
			case .ShowResult:
				return false
		}
	}
}

extension SearchViewStates{
	var toStoryboardName:String?{
		switch self {
		case .ToSpecie:
			return "Species"
		default:
			return nil
		}
	}
	
	var toViewControllerName:String?{
		switch self {
		case .ToSpecie:
			return "SpeciesViewController"
		default:
			return nil
		}
	}
}
