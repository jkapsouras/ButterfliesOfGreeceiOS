//
//  PhotoViewStates.swift
//  ButterfliesOfGreece
//
//  Created by Ioannis Kapsouras on 23/8/20.
//  Copyright © 2020 Ioannis Kapsouras. All rights reserved.
//

import Foundation

enum PhotosViewStates:ViewState{
	case SwitchViewStyle(currentArrange:ViewArrange)
	case ToPhoto(photoId:Int)
	case ShowPhotos(photos:[ButterflyPhoto])
	
	var isTransition: Bool{
		switch self {
			case .ToPhoto:
				return true
			case .SwitchViewStyle,
				 .ShowPhotos:
				return false
		}
	}
}
