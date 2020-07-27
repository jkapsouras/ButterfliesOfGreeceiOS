//
//  FamiliesPresenter.swift
//  ButterfliesOfGreece
//
//  Created by Ioannis Kapsouras on 27/7/20.
//  Copyright © 2020 Ioannis Kapsouras. All rights reserved.
//

import Foundation
enum viewArrange{
	case list
	case grid
	
	 func changeArrange()->viewArrange{
		switch self {
		case .grid:
			return .list
		case .list:
			return  .grid
		}
	}
}

class FamiliesPresenter:BasePresenter{
	
	var currentArrange:viewArrange
	
	init(mainThread:MainThreadProtocol,backgroundThread:BackgroundThreadProtocol)
	{
		currentArrange = .grid
		super.init(backScheduler: backgroundThread, mainScheduler: mainThread)
	}
	
	override func HandleEvent(uiEvents uiEvent: UiEvent) {
		switch uiEvent {
			case let familyEvent as FamiliesEvents:
				switch familyEvent {
				case .familyClicked(let familyId):
					state.onNext(FamiliesViewStates.ToSpecies(familyId: familyId))
				case .switchViewStyle:
					currentArrange = currentArrange.changeArrange()
					state.onNext(FamiliesViewStates.SwitchViewStyle(currentArrange: currentArrange))
			}
			default:
			state.onNext(GeneralViewState.idle)
		}
	}
}
