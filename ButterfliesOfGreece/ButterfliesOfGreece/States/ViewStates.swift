//
//  ViewStates.swift
//  ButterfliesOfGreece
//
//  Created by Apprecot on 27/7/20.
//  Copyright © 2020 Ioannis Kapsouras. All rights reserved.
//

import Foundation

protocol ViewState {
	var isTransition:Bool{get}
}

enum GeneralViewState:ViewState{
	case idle
	
	var isTransition: Bool{
		return false
	}
}
