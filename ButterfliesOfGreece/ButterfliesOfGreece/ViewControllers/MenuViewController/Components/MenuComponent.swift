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
	
	init(field:UIButton, contribute:UIButton, about:UIButton) {
        FieldButton=field
		ContributeButton=contribute
		AboutButton = about
        
		let events = Observable.merge(FieldButton.rx.tap.map{tap in
			MenuEvent.fieldClicked as UiEvent},
										ContributeButton.rx.tap.map{tap in
										MenuEvent.contributeClicked as UiEvent},
										AboutButton.rx.tap.map{tap in
										MenuEvent.aboutClicked as UiEvent})
        
        uiEvents = events
    }
    
    public func renderViewState(viewState: ViewState) {
        
    }
}
