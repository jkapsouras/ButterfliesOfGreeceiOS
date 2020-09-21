//
//  SpeciesTableComponent.swift
//  ButterfliesOfGreece
//
//  Created by Apprecot on 20/8/20.
//  Copyright © 2020 Ioannis Kapsouras. All rights reserved.
//

import Foundation
import RxSwift

class SpeciesTableComponent : UiComponent
{
	let event:PublishSubject<UiEvent> = PublishSubject()
	let photosTableView:PhotosTableView
	let uiEvents: Observable<UiEvent>
    
	init(view:PhotosTableView) {
		photosTableView=view
		uiEvents = Observable.merge(photosTableView.UiEvents,event.asObservable())
    }
    
    public func renderViewState(viewState: ViewState) {
		if let state = viewState as? SpeciesViewStates{
			switch state {
			case SpeciesViewStates.ShowSpecies(let data, let fromSearch):
				print("number of species: \(data.count)")
				photosTableView.ShowSpecies(species: data, fromSearch: fromSearch)
			case SpeciesViewStates.SwitchViewStyle(let arrange):
				if(arrange == .grid){
					photosTableView.Hide()
				}
				else{
					photosTableView.Show()
				}
			default:
				print("default state")
			}
		}
    }
}
