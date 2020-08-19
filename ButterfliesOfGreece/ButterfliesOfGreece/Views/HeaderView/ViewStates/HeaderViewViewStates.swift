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
	
	var isTransition: Bool{
		switch self {
		case .updateFolderIcon:
			return false
		}
	}
	
}
