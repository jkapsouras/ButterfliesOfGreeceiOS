//
//  FamiliesComponent.swift
//  ButterfliesOfGreece
//
//  Created by Ioannis Kapsouras on 10/8/20.
//  Copyright © 2020 Ioannis Kapsouras. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import UIKit

class FamiliesTableComponent : UiComponent
{
	let event:PublishSubject<UiEvent> = PublishSubject()
	let photosTableView:PhotosTableView
	let uiEvents: Observable<UiEvent>
    
	init(view:PhotosTableView) {
		photosTableView=view
		uiEvents = Observable.merge(photosTableView.UiEvents,event.asObservable())
    }
    
    public func renderViewState(viewState: ViewState) {
		if let state = viewState as? FamiliesViewStates{
			switch state {
			case FamiliesViewStates.ShowFamilies(let data):
				print("number of families: \(data.count)")
			case FamiliesViewStates.SwitchViewStyle(let arrange):
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
