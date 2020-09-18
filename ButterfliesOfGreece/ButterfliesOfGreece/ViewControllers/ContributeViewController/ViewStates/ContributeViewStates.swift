//
//  ContributeViewStates.swift
//  ButterfliesOfGreece
//
//  Created by Ioannis Kapsouras on 18/9/20.
//  Copyright © 2020 Ioannis Kapsouras. All rights reserved.
//

import Foundation

enum ContributeViewStates:ViewState{
	case showDatePicker
	case hideDatePicker
	case setDate(date:String)
	
	var isTransition: Bool{
		return false
	}
}
