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
	case toPrintPhotos
	
	var isTransition: Bool{
		switch self {
		case .toSearch,
			 .toPrintPhotos:
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
		case .toPrintPhotos:
			return "PrintToPdf"
		default:
			return nil
		}
	}
	
	var toViewControllerName:String?{
		switch self {
		case .toSearch:
			return "SearchViewController"
			case .toPrintPhotos:
			return "PrintToPdfViewController"
		default:
			return nil
		}
	}
}
