//
//  ContributeEvents.swift
//  ButterfliesOfGreece
//
//  Created by Ioannis Kapsouras on 18/9/20.
//  Copyright © 2020 Ioannis Kapsouras. All rights reserved.
//

import Foundation
import CoreLocation

enum ContributeEvents:UiEvent{
	case textDateClicked
	case buttonDoneClicked(date:Date)
	case locationFetched(location:CLLocationCoordinate2D)
	case textNameSet(name:String)
	case textAltitudeSet(altitude:String)
	case textPlaceSet(place:String)
	case textStateSet(stage:String)
	case textLatitudeSet(latitude:String)
	case textLongitudeSet(longitude:String)
	case textGenusSpeciesSet(genusSpecies:String)
	case textNameSpeciesSet(nameSpecies:String)
	case textCommentsSet(comments:String)
	case addClicked
	case exportClicked
}
