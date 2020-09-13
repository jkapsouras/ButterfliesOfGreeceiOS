//
//  HeaderViewViewStates.swift
//  ButterfliesOfGreece
//
//  Created by Ioannis Kapsouras on 13/8/20.
//  Copyright © 2020 Ioannis Kapsouras. All rights reserved.
//

import Foundation

enum HeaderViewViewStates:ViewState{
	case updateFolderIcon(numberOfPhotos:Int)
	case setHeaderTitle(headerTitle:String)
	case toSearch
	
	var isTransition: Bool{
		switch self {
		case .toSearch:
			return true
		case .updateFolderIcon,
			 .setHeaderTitle:
			return false
		}
	}
}

extension HeaderViewViewStates{
	var toStoryboardName:String?{
		switch self {
		case .toSearch:
			return "Search"
		default:
			return nil
		}
	}
	
	var toViewControllerName:String?{
		switch self {
		case .toSearch:
			return "SearchViewController"
		default:
			return nil
		}
	}
}
