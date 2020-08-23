//
//  SpeciesPresenter.swift
//  ButterfliesOfGreece
//
//  Created by Apprecot on 19/8/20.
//  Copyright © 2020 Ioannis Kapsouras. All rights reserved.
//

import Foundation
import RxSwift

class SpeciesPresenter:BasePresenter{
	
	var speciesState:SpeciesState
	var headerState:HeaderState
	var speciesRepository:SpeciesRepository
	var navigationRepository:NavigationRepository
	var photosToPrintRepository:PhotosToPrintRepository
	
	init(mainThread:MainThreadProtocol,backgroundThread:BackgroundThreadProtocol,
		 speciesRepository:SpeciesRepository, navigationRepository:NavigationRepository,
		 photosToPrintRepository:PhotosToPrintRepository)
	{
		self.speciesRepository = speciesRepository
		self.photosToPrintRepository = photosToPrintRepository
		self.navigationRepository = navigationRepository
		speciesState = SpeciesState(species: [Specie]())
		headerState = HeaderState(currentArrange: .grid, photosToPrint: nil, headerName: "Species")
		super.init(backScheduler: backgroundThread, mainScheduler: mainThread)
	}
	
	override func setupEvents() {
		_ = Observable.zip(navigationRepository.getFamilyId(),navigationRepository.getViewArrange(),resultSelector: {id, arrange in (id, arrange)})
			.subscribe(onNext: {data in
				self.emitter.onNext(SpeciesEvents.loadSpecies(familyId: data.0))
				self.emitter.onNext(HeaderViewEvents.initState(currentArrange: data.1))})
	}
	
	override func HandleEvent(uiEvents uiEvent: UiEvent) {
		switch uiEvent {
			case let specieEvent as SpeciesEvents:
				handleSpeciesEvents(specieEvent: specieEvent)
			case let headerEvent as HeaderViewEvents:
				handleHeaderViewEvents(headerEvent: headerEvent)
			default:
				state.onNext(GeneralViewState.idle)
		}
	}
	
	func updateHeaderState(photos:[ButterflyPhoto], specieId:Int) -> HeaderState{
		headerState = headerState.with(photos: photos)
		let specie = speciesState.species.first{$0.id==specieId}
		let photos = specie?.photos
		headerState = headerState.with(photos:photos)
		return headerState
	}
	
	func handleSpeciesEvents(specieEvent: SpeciesEvents){
		switch specieEvent {
			case .specieClicked(let specieId):
				_ = navigationRepository
				.selectSpecieId(specieId: specieId)
				.subscribe(onNext: {_ in self.state.onNext(SpeciesViewStates.ToPhotos)})
			case .loadSpecies(let familyId):
				_ = Observable.zip(speciesRepository.getSelectedFamilyName(familyId: familyId).map{familyName -> HeaderState in
					self.headerState = self.headerState.with(headerName: familyName)
					return self.headerState
					},
					speciesRepository.getSpeciesOfFamily(familyId:familyId).map{species -> SpeciesState in
					self.speciesState = self.speciesState.with(species: species)
					return self.speciesState
				}, resultSelector: {headerState, speciesState in (headerState, speciesState)})
					.subscribe(onNext: {data in
						self.state.onNext(HeaderViewViewStates.setHeaderTitle(headerTitle: data.0.headerName))
						self.state.onNext(SpeciesViewStates.ShowSpecies(species: data.1.species))})
			case .addPhotosForPrintClicked(let familyId):
				_ = photosToPrintRepository
					.getPhotosToPrint()
					.map{photos in return self.updateHeaderState(photos: photos, specieId: familyId)}
					.do(onNext: {photoState in self.photosToPrintRepository.savePhotosToPrint(photos: photoState.photosToPrint ?? [ButterflyPhoto]())})
					.subscribe(onNext: {headerState in self.state.onNext(HeaderViewViewStates.updateFolderIcon(numberOfPhotos: headerState.photosToPrint!.count))})
		}
	}
	
	func handleHeaderViewEvents(headerEvent: HeaderViewEvents){
		switch headerEvent {
			case .initState(let currentArrange):
				_ = photosToPrintRepository.getPhotosToPrint().map{photos -> HeaderState in
					self.headerState = self.headerState.with(arrange: currentArrange, photos: photos)
					return self.headerState
				}.subscribe(onNext: {headerState in self.state.onNext(HeaderViewViewStates.updateFolderIcon(numberOfPhotos: headerState.photosToPrint?.count ?? 0))
					self.state.onNext(SpeciesViewStates.SwitchViewStyle(currentArrange: headerState.currentArrange))
					
				})
			case .switchViewStyleClicked:
				_ = navigationRepository.changeViewArrange()
					.map{arrange -> HeaderState in
						self.headerState = self.headerState.with(arrange: arrange)
						return self.headerState
				}
					.subscribe(onNext: {headerState in self.state.onNext(SpeciesViewStates.SwitchViewStyle(currentArrange: headerState.currentArrange))})
			case .searchBarClicked:
				print("search bar clicked")
			case .printPhotosClicked:
				print("print photos clicked")
		}
	}
}
