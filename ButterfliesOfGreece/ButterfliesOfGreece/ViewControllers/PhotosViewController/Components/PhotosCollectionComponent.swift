//
//  PhotosCollectionComponent.swift
//  ButterfliesOfGreece
//
//  Created by Ioannis Kapsouras on 23/8/20.
//  Copyright © 2020 Ioannis Kapsouras. All rights reserved.
//

import Foundation
import RxSwift

class PhotosCollectionComponent: UiComponent
{
	let event:PublishSubject<UiEvent> = PublishSubject()
	let photosCollectionView:PhotosCollectionView
	let uiEvents: Observable<UiEvent>
	
	init(view:PhotosCollectionView) {
		photosCollectionView=view
		uiEvents = Observable.merge(photosCollectionView.UiEvents,event.asObservable())
	}
	
	public func renderViewState(viewState: ViewState) {
		if let state = viewState as? PhotosViewStates{
			switch state {
			case PhotosViewStates.ShowPhotos(let data):
					print("number of species: \(data.count)")
					photosCollectionView.ShowPhotos(photos: data)
				case PhotosViewStates.SwitchViewStyle(let arrange):
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
