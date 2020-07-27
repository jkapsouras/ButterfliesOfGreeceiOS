//
//  UiEvents.swift
//  ButterfliesOfGreece
//
//  Created by Apprecot on 27/7/20.
//  Copyright © 2020 Ioannis Kapsouras. All rights reserved.
//

import Foundation

protocol UiEvent{}

enum GeneralEvents:UiEvent{
	case idle
}

enum MenuEvent:UiEvent{
	case fieldClicked
	case introductionClicked
	case legalClicked
	case aboutClicked
	case contributeClicked
	case endangeredSpeciesClicked
	case onlineRecognitionClicked
	case offlineRecognitionClicked
}
