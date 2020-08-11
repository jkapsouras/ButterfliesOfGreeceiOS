//
//  FamiliesPresenter.swift
//  ButterfliesOfGreece
//
//  Created by Ioannis Kapsouras on 27/7/20.
//  Copyright © 2020 Ioannis Kapsouras. All rights reserved.
//

import Foundation
import RxSwift

enum ViewArrange{
	case list
	case grid
	
	 func changeArrange()->ViewArrange{
		switch self {
		case .grid:
			return .list
		case .list:
			return  .grid
		}
	}
}

class FamiliesPresenter:BasePresenter{
	
	var familiesState:FamiliesState
	
	init(mainThread:MainThreadProtocol,backgroundThread:BackgroundThreadProtocol)
	{
		familiesState = FamiliesState(arrange: .grid)
		super.init(backScheduler: backgroundThread, mainScheduler: mainThread)
	}
	
	override func HandleEvent(uiEvents uiEvent: UiEvent) {
		switch uiEvent {
			case let familyEvent as FamiliesEvents:
				switch familyEvent {
				case .familyClicked(let familyId):
					state.onNext(FamiliesViewStates.ToSpecies(familyId: familyId))
				case .switchViewStyle:
					familiesState.currentArrange = familiesState.currentArrange.changeArrange()
					state.onNext(FamiliesViewStates.SwitchViewStyle(currentArrange: familiesState.currentArrange))
				case .loadFamilies:
					state.onNext(FamiliesViewStates.ShowFamilies(families: familiesState.families))
			}
			default:
			state.onNext(GeneralViewState.idle)
		}
	}
}
