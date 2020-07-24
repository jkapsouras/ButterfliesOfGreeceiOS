//
//  MenuPresenter.swift
//  ButterfliesOfGreece
//
//  Created by Ioannis Kapsouras on 24/7/20.
//  Copyright © 2020 Ioannis Kapsouras. All rights reserved.
//

import Foundation

class MenuPresenter:BasePresenter{
	
	init(mainThread:MainThreadProtocol,backgroundThread:BackgroundThreadProtocol)
	{
		super.init(backScheduler: backgroundThread, mainScheduler: mainThread)
	}
	
	override func HandleEvent(uiEvent: UiEvent) {
		switch uiEvent {
		case is FieldClicked:
			state.onNext(NavigateToField())
		default:
			state.onNext(IdleState())
		}
	}
}
