//
//  ModalPhotoComponent.swift
//  ButterfliesOfGreece
//
//  Created by Ioannis Kapsouras on 27/8/20.
//  Copyright © 2020 Ioannis Kapsouras. All rights reserved.
//

import Foundation
import RxSwift

class ModolPhotoComponent : UiComponent
{
	let event:PublishSubject<UiEvent> = PublishSubject()
	let pageController:PageModalViewController
	let uiEvents: Observable<UiEvent>
    
	init(view:PageModalViewController) {
		pageController=view
		uiEvents = Observable.never()
    }
    
    public func renderViewState(viewState: ViewState) {
		if let state = viewState as? ModalViewStates{
			switch state {
			case ModalViewStates.ShowPhotosStartingWith(let index,let photos):
				pageController.setUpPagesStartingWith(index: index, photos: photos)
			}
		}
    }
}
