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
	
	var isTransition: Bool{
		switch self {
		case .updateFolderIcon,
			 .setHeaderTitle:
			return false
		}
	}
	
}
