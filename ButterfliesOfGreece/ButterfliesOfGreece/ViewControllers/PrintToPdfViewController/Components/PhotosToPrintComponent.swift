//
//  PhotosToPrintComponent.swift
//  ButterfliesOfGreece
//
//  Created by Ioannis Kapsouras on 14/9/20.
//  Copyright © 2020 Ioannis Kapsouras. All rights reserved.
//

import Foundation
import RxSwift

class PhotosToPrintComponent : UiComponent
{
	let photosTableView:PhotosTableView
	let uiEvents: Observable<UiEvent>
    
	init(view:PhotosTableView) {
		photosTableView=view
		uiEvents = photosTableView.UiEvents
    }
    
    public func renderViewState(viewState: ViewState) {
		if let state = viewState as? PrintToPdfViewStates{
			switch state {
			case PrintToPdfViewStates.showPhotos(let data):
				print("number of species: \(data.count)")
				photosTableView.ShowPhotosToPrint(photos: data)
			}
		}
    }
}
