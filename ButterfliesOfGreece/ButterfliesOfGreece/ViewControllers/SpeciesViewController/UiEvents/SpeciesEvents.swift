//
//  SpeciesEvents.swift
//  ButterfliesOfGreece
//
//  Created by Apprecot on 19/8/20.
//  Copyright © 2020 Ioannis Kapsouras. All rights reserved.
//

import Foundation

enum SpeciesEvents:UiEvent{
	case loadSpecies(familyId:Int)
	case specieClicked(id:Int)
	case addPhotosForPrintClicked(specieId:Int)
}
