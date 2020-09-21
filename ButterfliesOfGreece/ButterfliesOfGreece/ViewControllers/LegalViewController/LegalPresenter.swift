//
//  LegalPresenter.swift
//  ButterfliesOfGreece
//
//  Created by Ioannis Kapsouras on 20/9/20.
//  Copyright © 2020 Ioannis Kapsouras. All rights reserved.
//

import Foundation

class LegalPresenter:BasePresenter{
	init(mainThread:MainThreadProtocol,backgroundThread:BackgroundThreadProtocol)
	{
		super.init(backScheduler: backgroundThread, mainScheduler: mainThread)
	}
	
	override func setupEvents() {
		state.onNext(LegalViewStates.showTermsPdf(document: Constants.TermsPdf))
		state.onNext(LegalViewStates.showPopup)
	}
	
	override func HandleEvent(uiEvents: UiEvent) {
		switch uiEvents {
		case let legalEvents as LegalEvents:
			switch legalEvents {
			case .termsClicked:
				state.onNext(LegalViewStates.showTermsPdf(document: Constants.TermsPdf))
				state.onNext(LegalViewStates.showPopup)
			case .formsClicked:
				state.onNext(LegalViewStates.showFormsPdf(document: Constants.FormsPdf))
				state.onNext(LegalViewStates.showPopup)
			case .okClicked:
				state.onNext(LegalViewStates.hidePopup)
			}
		default:
			state.onNext(GeneralViewState.idle)
		}
	}
}
