//
//  ModalViewStates.swift
//  ButterfliesOfGreece
//
//  Created by Ioannis Kapsouras on 26/8/20.
//  Copyright © 2020 Ioannis Kapsouras. All rights reserved.
//

import Foundation

enum ModalViewStates:ViewState{
	case ShowPhotosStartingWith(index:Int, photos:[String])
	
	var isTransition: Bool{
		switch self {
			case .ShowPhotosStartingWith:
			return false
		}
	}
}
