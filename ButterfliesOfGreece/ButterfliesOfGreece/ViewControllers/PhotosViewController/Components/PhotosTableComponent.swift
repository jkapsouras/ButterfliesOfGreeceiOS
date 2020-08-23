//
//  PhotosTableComponent.swift
//  ButterfliesOfGreece
//
//  Created by Ioannis Kapsouras on 23/8/20.
//  Copyright © 2020 Ioannis Kapsouras. All rights reserved.
//

import Foundation
import RxSwift

class PhotosTableComponent : UiComponent
{
	let event:PublishSubject<UiEvent> = PublishSubject()
	let photosTableView:PhotosTableView
	let uiEvents: Observable<UiEvent>
    
	init(view:PhotosTableView) {
		photosTableView=view
		uiEvents = Observable.merge(photosTableView.UiEvents,event.asObservable())
    }
    
    public func renderViewState(viewState: ViewState) {
		if let state = viewState as? PhotosViewStates{
			switch state {
			case PhotosViewStates.ShowPhotos(let data):
				print("number of species: \(data.count)")
				photosTableView.ShowPhotos(photos: data)
			case PhotosViewStates.SwitchViewStyle(let arrange):
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
