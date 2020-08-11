//
//  FamiliesCollectionComponent.swift
//  ButterfliesOfGreece
//
//  Created by Ioannis Kapsouras on 11/8/20.
//  Copyright © 2020 Ioannis Kapsouras. All rights reserved.
//

import Foundation
import RxSwift

class FamiliesCollectionComponent: UiComponent
{
	let event:PublishSubject<UiEvent> = PublishSubject()
	let photosCollectionView:PhotosCollectionView
	let uiEvents: Observable<UiEvent>
    
	init(view:PhotosCollectionView) {
		photosCollectionView=view
		uiEvents = Observable.merge(photosCollectionView.UiEvents,event.asObservable())
    }
    
    public func renderViewState(viewState: ViewState) {
		if let state = viewState as? FamiliesViewStates{
			switch state {
			case FamiliesViewStates.ShowFamilies(let data):
				print("number of families: \(data.count)")
			case FamiliesViewStates.SwitchViewStyle(let arrange):
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

