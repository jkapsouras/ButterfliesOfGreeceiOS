//
//  SpeciesState.swift
//  ButterfliesOfGreece
//
//  Created by Apprecot on 19/8/20.
//  Copyright © 2020 Ioannis Kapsouras. All rights reserved.
//

import Foundation

struct SpeciesState {
	let species:[Specie]
	
	init(species:[Specie]){
		self.species = species
	}
}

extension SpeciesState{
	func with(species:[Specie]? = nil) -> SpeciesState{
		return SpeciesState(species: species ?? self.species)
	}
}
