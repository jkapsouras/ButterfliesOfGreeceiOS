//
//  SpeciesCollectionComponent.swift
//  ButterfliesOfGreece
//
//  Created by Apprecot on 20/8/20.
//  Copyright © 2020 Ioannis Kapsouras. All rights reserved.
//

import Foundation
import RxSwift

class SpeciesCollectionComponent: UiComponent
{
	let event:PublishSubject<UiEvent> = PublishSubject()
	let photosCollectionView:PhotosCollectionView
	let uiEvents: Observable<UiEvent>
	
	init(view:PhotosCollectionView) {
		photosCollectionView=view
		uiEvents = Observable.merge(photosCollectionView.UiEvents,event.asObservable())
	}
	
	public func renderViewState(viewState: ViewState) {
		if let state = viewState as? SpeciesViewStates{
			switch state {
			case SpeciesViewStates.ShowSpecies(let data, _):
					print("number of species: \(data.count)")
					photosCollectionView.ShowSpecies(species: data)
				case SpeciesViewStates.SwitchViewStyle(let arrange):
					if(arrange == .list){
						photosCollectionView.Hide()
					}
					else{
						photosCollectionView.Show()
				}
				default:
					print("default state")
			}
		}
	}
}
