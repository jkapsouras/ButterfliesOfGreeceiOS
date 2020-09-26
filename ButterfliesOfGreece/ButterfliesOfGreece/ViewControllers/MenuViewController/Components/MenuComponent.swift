//
//  MenuComponent.swift
//  ButterfliesOfGreece
//
//  Created by Ioannis Kapsouras on 24/7/20.
//  Copyright © 2020 Ioannis Kapsouras. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import UIKit

class MenuComponent : UiComponent
{
	var uiEvents: Observable<UiEvent>
	let FieldButton:UIButton
	let ContributeButton:UIButton
	let AboutButton:UIButton
	let IntroductionButton:UIButton
	let EndangeredButton:UIButton
	let LegalButton:UIButton
	let RecognitionButton:UIButton
	
	init(field:UIButton, contribute:UIButton, about:UIButton, introduction:UIButton, endangered:UIButton, legal:UIButton, recognition:UIButton) {
		FieldButton=field
		ContributeButton=contribute
		AboutButton = about
		IntroductionButton = introduction
		EndangeredButton = endangered
		LegalButton = legal
		RecognitionButton = recognition
		
		let events = Observable.merge(FieldButton.rx.tap.map{tap in
										MenuEvent.fieldClicked as UiEvent},
									  ContributeButton.rx.tap.map{tap in
										MenuEvent.contributeClicked as UiEvent},
									  AboutButton.rx.tap.map{tap in
										MenuEvent.aboutClicked as UiEvent},
									  IntroductionButton.rx.tap.map{tap in
										MenuEvent.introductionClicked as UiEvent},
									  EndangeredButton.rx.tap.map{tap in
										MenuEvent.endangeredSpeciesClicked as UiEvent},
									  LegalButton.rx.tap.map{tap in
										MenuEvent.legalClicked as UiEvent},
									  RecognitionButton.rx.tap.map{tap in
										MenuEvent.recognitionClicked
									  })
		
		uiEvents = events
	}
	
	public func renderViewState(viewState: ViewState) {}
}
		
