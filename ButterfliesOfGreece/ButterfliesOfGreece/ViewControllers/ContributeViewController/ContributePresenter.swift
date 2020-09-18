//
//  ContributePresenter.swift
//  ButterfliesOfGreece
//
//  Created by Ioannis Kapsouras on 18/9/20.
//  Copyright © 2020 Ioannis Kapsouras. All rights reserved.
//

import Foundation

class ContributePresenter:BasePresenter{
	
	override func setupEvents() {
		
	}
	
	override func HandleEvent(uiEvents: UiEvent) {
		switch uiEvents {
		case let contributeEvents as ContributeEvents:
			switch contributeEvents {
			case .TextDateClicked:
				state.onNext(ContributeViewStates.showDatePicker)
			case .ButtonDoneClicked(let date):
				state.onNext(ContributeViewStates.hideDatePicker)
				state.onNext(ContributeViewStates.setDate(date: date.description))
			}
		default:
			state.onNext(GeneralViewState.idle)
		}
	}
}
