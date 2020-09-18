//
//  ContributeComponent.swift
//  ButterfliesOfGreece
//
//  Created by Ioannis Kapsouras on 18/9/20.
//  Copyright © 2020 Ioannis Kapsouras. All rights reserved.
//

import Foundation
import RxSwift

class ContributeComponent : UiComponent
{
	let view:ContributeView
	let navigationItem:UINavigationItem
	let uiEvents: Observable<UiEvent>
	let emitter:PublishSubject<UiEvent> = PublishSubject()
	
	init(view:ContributeView, navigationItem:UINavigationItem) {
		self.view = view
		self.navigationItem = navigationItem
		uiEvents = Observable.merge(self.view.UiEvents,emitter.asObservable())
		// Create the info button
		let infoButton = UIButton(type: .infoLight)
		infoButton.tintColor = Constants.Colors.contribute(darkMode: true).color

		// You will need to configure the target action for the button itself, not the bar button itemr
		infoButton.addTarget(self, action: #selector(infoTapped), for: .touchUpInside)

		// Create a bar button item using the info button as its custom view
		let info = UIBarButtonItem(customView: infoButton)

		// Use it as required
		self.navigationItem.setRightBarButton(info, animated: true)
	}
	
	@objc func infoTapped(){
		print("tapped")
	}
	
	public func renderViewState(viewState: ViewState) {
		if let state = viewState as? ContributeViewStates{
			switch state {
			case .showDatePicker:
				view.showDatePicker()
			case .hideDatePicker:
				view.hideDatePicker()
			case .setDate(let date):
				view.setDate(date: date)
			}
		}
	}
}
