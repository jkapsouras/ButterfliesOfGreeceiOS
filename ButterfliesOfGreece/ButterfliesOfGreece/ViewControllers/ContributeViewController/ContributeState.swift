//
//  ContributeState.swift
//  ButterfliesOfGreece
//
//  Created by Ioannis Kapsouras on 19/9/20.
//  Copyright © 2020 Ioannis Kapsouras. All rights reserved.
//

import Foundation

struct ContributeState {
	var contributionItem: ContributionItem
	
	init(contributionItem:ContributionItem){
		self.contributionItem = contributionItem
	}
}

extension ContributeState{
	func with(name:String? = nil, date:String? = nil, altitude:String? = nil, place:String? = nil, longitude:String? = nil, latitude:String? = nil, stage:String? = nil, genusSpecies:String? = nil, nameSpecies:String? = nil, comments: String? = nil) -> ContributeState{
		let item = self.contributionItem.with(name: name ?? self.contributionItem.name, date: date ?? self.contributionItem.date, altitude: altitude ?? self.contributionItem.altitude, place: place ?? self.contributionItem.place, longitude: longitude ?? self.contributionItem.longitude, latitude: latitude ?? self.contributionItem.latitude, stage: stage ?? self.contributionItem.stage, genusSpecies: genusSpecies ?? self.contributionItem.genusSpecies, nameSpecies: nameSpecies ?? self.contributionItem.nameSpecies, comments: comments ?? self.contributionItem.comments)
		return ContributeState(contributionItem: item)
	}
}
