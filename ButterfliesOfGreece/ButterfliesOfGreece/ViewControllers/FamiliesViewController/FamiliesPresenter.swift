//
//  FamiliesPresenter.swift
//  ButterfliesOfGreece
//
//  Created by Ioannis Kapsouras on 27/7/20.
//  Copyright © 2020 Ioannis Kapsouras. All rights reserved.
//

import Foundation
import RxSwift

enum ViewArrange{
	case list
	case grid
	
	func changeArrange()->ViewArrange{
		switch self {
		case .grid:
			return .list
		case .list:
			return  .grid
		}
	}
}

class FamiliesPresenter:BasePresenter{
	
	var familiesState:FamiliesState
	var headerState:HeaderState
	var familiesRepository:FamiliesRepository
	var photosToPrintRepository:PhotosToPrintRepository
	
	init(mainThread:MainThreadProtocol,backgroundThread:BackgroundThreadProtocol, familiesRepository:FamiliesRepository, photosToPrintRepository:PhotosToPrintRepository)
	{
		self.familiesRepository = familiesRepository
		self.photosToPrintRepository = photosToPrintRepository
		familiesState = FamiliesState(families: [Family]())
		headerState = HeaderState(arrange: .grid, photos: nil)
		super.init(backScheduler: backgroundThread, mainScheduler: mainThread)
	}
	
	override func setupEvents() {
		emitter.onNext(FamiliesEvents.loadFamilies)
		emitter.onNext(HeaderViewEvents.initState(arrange: .list))
	}
	
	override func HandleEvent(uiEvents uiEvent: UiEvent) {
		switch uiEvent {
		case let familyEvent as FamiliesEvents:
			handleFamiliesEvents(familyEvent: familyEvent)
		case let headerEvent as HeaderViewEvents:
			handleHeaderViewEvents(headerEvent: headerEvent)
		default:
			state.onNext(GeneralViewState.idle)
		}
	}
	
	func updateHeaderState(photos:[ButterflyPhoto], familyId:Int) -> HeaderState{
		headerState = headerState.with(photos: photos)
		let family = familiesState.families.first{$0.id==familyId}
		let photos = family?.species.flatMap{$0.photos}
		headerState = headerState.with(photos:photos)
		return headerState
	}
	
	func handleFamiliesEvents(familyEvent: FamiliesEvents){
		switch familyEvent {
		case .familyClicked(let familyId):
			state.onNext(FamiliesViewStates.ToSpecies(familyId: familyId))
		case .loadFamilies:
			_ = familiesRepository.getAllFamilies().map{families -> FamiliesState in
				self.familiesState = self.familiesState.with(families: families)
				return self.familiesState
			}.subscribe(onNext: {familieState in self.state.onNext(FamiliesViewStates.ShowFamilies(families: familieState.families))})
		case .addPhotosForPrintClicked(let familyId):
			_ = photosToPrintRepository
				.getPhotosToPrint()
				.map{photos in return self.updateHeaderState(photos: photos, familyId: familyId)}
//				.do(onNext: {photoState in self.photosToPrintRepository.savePhotosToPrint(photos: photoState.photosToPrint ?? [ButterflyPhoto]())})
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
				self.state.onNext(FamiliesViewStates.SwitchViewStyle(currentArrange: headerState.currentArrange))
			})
		case .switchViewStyleClicked:
			headerState = headerState.with(arrange: headerState.currentArrange.changeArrange())
			state.onNext(FamiliesViewStates.SwitchViewStyle(currentArrange: headerState.currentArrange))
		case .searchBarClicked:
			print("search bar clicked")
		case .printPhotosClicked:
			print("print photos clicked")
		}
	}
}
