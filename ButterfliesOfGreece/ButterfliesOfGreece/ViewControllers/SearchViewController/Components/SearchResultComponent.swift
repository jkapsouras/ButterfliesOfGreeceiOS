//
//  SearchResultComponent.swift
//  ButterfliesOfGreece
//
//  Created by Ioannis Kapsouras on 12/9/20.
//  Copyright © 2020 Ioannis Kapsouras. All rights reserved.
//

import Foundation
import RxSwift

class SearchResultComponent : UiComponent
{
	let event:PublishSubject<UiEvent> = PublishSubject()
	let photosTableView:PhotosTableView
	let uiEvents: Observable<UiEvent>
    
	init(view:PhotosTableView) {
		photosTableView=view
		uiEvents = Observable.merge(photosTableView.UiEvents,event.asObservable())
    }
    
    public func renderViewState(viewState: ViewState) {
		if let state = viewState as? SearchViewStates{
			switch state {
			case SearchViewStates.ShowResult(let result, let fromSearch):
				print("number of species: \(result.count)")
				photosTableView.ShowSpecies(species: result, fromSearch: fromSearch)
			default:
				print("default state")
			}
		}
    }
}
