//
//  SearchHeaderComponent.swift
//  ButterfliesOfGreece
//
//  Created by Ioannis Kapsouras on 12/9/20.
//  Copyright © 2020 Ioannis Kapsouras. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class SearchHeaderComponent : UiComponent
{
	let event:PublishSubject<UiEvent> = PublishSubject()
	let searchBar:UISearchBar
	let uiEvents: Observable<UiEvent>
	
	init(searchBar:UISearchBar) {
		self.searchBar=searchBar
		uiEvents = searchBar.rx.text.map{term in SearchEvents.searchWith(term: term ?? "")}
	}
	
	public func renderViewState(viewState: ViewState) {
	}
}
