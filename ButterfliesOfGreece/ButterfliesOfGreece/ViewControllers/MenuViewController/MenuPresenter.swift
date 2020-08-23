//
//  MenuPresenter.swift
//  ButterfliesOfGreece
//
//  Created by Ioannis Kapsouras on 24/7/20.
//  Copyright © 2020 Ioannis Kapsouras. All rights reserved.
//

import Foundation

class MenuPresenter:BasePresenter{
	let responseMessages: [MenuEvent:MenuViewState] = [.fieldClicked: .toField,
												  .introductionClicked: .toIntroduction,
												  .aboutClicked:.toAbout,
												  .contributeClicked:.toContribute,
												  .endangeredSpeciesClicked:.toEndangered,
												  .legalClicked:.toLegal,
												  .offlineRecognitionClicked:.toOfflineRecognition,
												  .onlineRecognitionClicked:.toOnlineRecognition]
	
	init(mainThread:MainThreadProtocol,backgroundThread:BackgroundThreadProtocol)
	{
		super.init(backScheduler: backgroundThread, mainScheduler: mainThread)
	}
	
	override func HandleEvent(uiEvents uiEvent: UiEvent) {
		switch uiEvent {
			case let menuEvent as MenuEvent:
				guard let certainEvent = responseMessages[menuEvent] else{
					state.onNext(GeneralViewState.idle)
					return
				}
				state.onNext(certainEvent)
			default:
			state.onNext(GeneralViewState.idle)
		}
	}
	
	override func setupEvents() {
		
	}
}

