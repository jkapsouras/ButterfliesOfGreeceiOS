//
//  SearchEvents.swift
//  ButterfliesOfGreece
//
//  Created by Ioannis Kapsouras on 5/9/20.
//  Copyright © 2020 Ioannis Kapsouras. All rights reserved.
//

import Foundation

enum SearchEvents:UiEvent{
	case searchWith(term:String)
	case specieClicked(specie:Specie)
}
