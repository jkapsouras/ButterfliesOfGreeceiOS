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
	case ToPhotosOfSpecie
	
	var isTransition: Bool{
		switch self {
			case .ToPhotosOfSpecie:
				return true
			case .ShowResult:
				return false
		}
	}
}

extension SearchViewStates{
	var toStoryboardName:String?{
		switch self {
		case .ToPhotosOfSpecie:
			return "Photos"
		default:
			return nil
		}
	}
	
	var toViewControllerName:String?{
		switch self {
		case .ToPhotosOfSpecie:
			return "PhotosViewController"
		default:
			return nil
		}
	}
}
