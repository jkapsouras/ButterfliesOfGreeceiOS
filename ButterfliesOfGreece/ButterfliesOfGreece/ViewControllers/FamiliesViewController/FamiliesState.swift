//
//  FamiliesState.swift
//  ButterfliesOfGreece
//
//  Created by Ioannis Kapsouras on 10/8/20.
//  Copyright © 2020 Ioannis Kapsouras. All rights reserved.
//

import Foundation

struct FamiliesState {
	let families:[Family]
	
	init(families:[Family]){
		self.families = families
	}
}

extension FamiliesState{
	func with(families:[Family]? = nil) -> FamiliesState{
		return FamiliesState(families: families ?? self.families)
	}
}
