//
//  SpeciesHeaderComponent.swift
//  ButterfliesOfGreece
//
//  Created by Apprecot on 20/8/20.
//  Copyright © 2020 Ioannis Kapsouras. All rights reserved.
//

import Foundation
import RxSwift

class SpeciesHeaderComponent : UiComponent
{
	let event:PublishSubject<UiEvent> = PublishSubject()
	let headerView:HeaderView
	let uiEvents: Observable<UiEvent>
	
	init(view:HeaderView) {
		headerView=view
		uiEvents = Observable.merge(headerView.UiEvents,event.asObservable())
	}
	
	public func renderViewState(viewState: ViewState) {
		if let state = viewState as? SpeciesViewStates{
			switch state {
				case SpeciesViewStates.SwitchViewStyle(let arrange):
					headerView.changeViewForViewArrange(viewArrange: arrange)
				default:
					print("default state")
			}
		}
		if let state = viewState as? HeaderViewViewStates{
			switch state {
				case HeaderViewViewStates.updateFolderIcon(let numberOfPhotos):
					headerView.updateNumberOfPhotos(number: numberOfPhotos)
			case HeaderViewViewStates.setHeaderTitle(let headerTitle):
				headerView.updateTitle(title: headerTitle)
			default:
				break
			}
		}
	}
}
