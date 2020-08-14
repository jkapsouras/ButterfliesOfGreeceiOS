//
//  HeaderState.swift
//  ButterfliesOfGreece
//
//  Created by Ioannis Kapsouras on 14/8/20.
//  Copyright © 2020 Ioannis Kapsouras. All rights reserved.
//

import Foundation

struct HeaderState {
	var photosToPrint:[ButterflyPhoto]?
	var currentArrange:ViewArrange
	
	init(arrange:ViewArrange){
		currentArrange = arrange
	}
}
