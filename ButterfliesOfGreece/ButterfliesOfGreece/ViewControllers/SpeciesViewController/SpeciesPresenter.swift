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
	var photosToPrintRepository:PhotosToPrintRepository
	var familyId:Int?
	
	init(mainThread:MainThreadProtocol,backgroundThread:BackgroundThreadProtocol, speciesRepository:SpeciesRepository, photosToPrintRepository:PhotosToPrintRepository)
	{
		self.speciesRepository = speciesRepository
		self.photosToPrintRepository = photosToPrintRepository
		speciesState = SpeciesState(species: [Specie]())
		headerState = HeaderState(arrange: .grid, photos: nil)
		super.init(backScheduler: backgroundThread, mainScheduler: mainThread)
	}
	
	func setFamilyId(familyId:Int){
		self.familyId = familyId
	}
	
	override func setupEvents() {
		emitter.onNext(SpeciesEvents.loadSpecies(familyId: 0))
		emitter.onNext(HeaderViewEvents.initState(arrange: .list))
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
				state.onNext(SpeciesViewStates.ToPhotos(specieId: specieId))
			case .loadSpecies(let familyId):
				_ = speciesRepository.getSpeciesOfFamily(familyId: familyId).map{species -> SpeciesState in
					self.speciesState = self.speciesState.with(species: species)
					return self.speciesState
				}.subscribe(onNext: {familieState in self.state.onNext(SpeciesViewStates.ShowSpecies(species: self.speciesState.species))})
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
			case .initState(let arrange):
				_ = photosToPrintRepository.getPhotosToPrint().map{photos -> HeaderState in
					self.headerState = self.headerState.with(arrange: arrange, photos: photos)
					return self.headerState
				}.subscribe(onNext: {headerState in self.state.onNext(HeaderViewViewStates.updateFolderIcon(numberOfPhotos: headerState.photosToPrint?.count ?? 0))
					self.state.onNext(SpeciesViewStates.SwitchViewStyle(currentArrange: headerState.currentArrange))
				})
			case .switchViewStyleClicked:
				headerState = headerState.with(arrange: headerState.currentArrange.changeArrange())
				state.onNext(SpeciesViewStates.SwitchViewStyle(currentArrange: headerState.currentArrange))
			case .searchBarClicked:
				print("search bar clicked")
			case .printPhotosClicked:
				print("print photos clicked")
		}
	}
}
