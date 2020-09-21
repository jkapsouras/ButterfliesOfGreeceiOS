//
//  SearchPresenter.swift
//  ButterfliesOfGreece
//
//  Created by Ioannis Kapsouras on 5/9/20.
//  Copyright © 2020 Ioannis Kapsouras. All rights reserved.
//

import Foundation
import RxSwift

class SearchPresenter:BasePresenter{
	
	var searchState:SearchState
	var speciesRepository:SpeciesRepository
	var navigationRepository:NavigationRepository
	
	init(mainThread:MainThreadProtocol,backgroundThread:BackgroundThreadProtocol,
		 speciesRepository:SpeciesRepository, navigationRepository:NavigationRepository)
	{
		self.speciesRepository = speciesRepository
		self.navigationRepository = navigationRepository
		searchState = SearchState(term: "", result: [Specie]())
		super.init(backScheduler: backgroundThread, mainScheduler: mainThread)
	}
	
	override func setupEvents() {
		self.emitter.onNext(SearchEvents.searchWith(term: searchState.term))
	}
	
	override func HandleEvent(uiEvents uiEvent: UiEvent) {
		switch uiEvent {
		case let searchEvent as SearchEvents:
			handleSearchEvents(searchEvent: searchEvent)
		default:
			state.onNext(GeneralViewState.idle)
		}
	}
	
	func handleSearchEvents(searchEvent: SearchEvents){
		switch searchEvent {
		case .searchWith(let term):
			_ = speciesRepository
				.getSpeciesFromSearchTerm(term: term)
				.map{result in
					self.searchState = self.searchState.with(term: term, result: result)
					return result
			}
				.subscribe(onNext:
					{result in self.state.onNext(SearchViewStates.ShowResult(result: result, fromSearch: true))})
		case .specieClicked(let specie):
			_ = navigationRepository.selectSpecieId(specieId: specie.id)
				.map{_ in self.navigationRepository.selectFamilyId(familyId: specie.familyId ?? 0)}
				.subscribe(onNext: {_ in
					self.state.onNext(SearchViewStates.ToSpecie)})
		}
	}
}
