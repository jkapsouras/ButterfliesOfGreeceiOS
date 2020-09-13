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
	var navigationRepository:NavigationRepository
	var photosToPrintRepository:PhotosToPrintRepository
	
	init(mainThread:MainThreadProtocol,backgroundThread:BackgroundThreadProtocol,
		 familiesRepository:FamiliesRepository, navigationRepository:NavigationRepository,
		 photosToPrintRepository:PhotosToPrintRepository)
	{
		self.familiesRepository = familiesRepository
		self.navigationRepository = navigationRepository
		self.photosToPrintRepository = photosToPrintRepository
		familiesState = FamiliesState(families: [Family]())
		headerState = HeaderState(currentArrange: .grid, photosToPrint: nil, headerName: "Families")
		super.init(backScheduler: backgroundThread, mainScheduler: mainThread)
	}
	
	override func setupEvents() {
		emitter.onNext(FamiliesEvents.loadFamilies)
		emitter.onNext(HeaderViewEvents.initState(currentArrange: .list))
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
			_ = navigationRepository
				.selectFamilyId(familyId:familyId)
				.subscribe(onNext: {_ in self.state.onNext(FamiliesViewStates.ToSpecies)})
		case .loadFamilies:
			_ = familiesRepository
				.getAllFamilies()
				.map{families -> FamiliesState in
					self.familiesState = self.familiesState.with(families: families)
					return self.familiesState
			}
			.subscribe(onNext: {familieState in self.state.onNext(FamiliesViewStates.ShowFamilies(families: familieState.families))})
		case .addPhotosForPrintClicked(let familyId):
			_ = photosToPrintRepository
				.getPhotosToPrint()
				.map{photos in return self.updateHeaderState(photos: photos, familyId: familyId)}
				.do(onNext: {photoState in self.photosToPrintRepository.savePhotosToPrint(photos: photoState.photosToPrint ?? [ButterflyPhoto]())})
				.subscribe(onNext: {headerState in self.state.onNext(HeaderViewViewStates.updateFolderIcon(numberOfPhotos: headerState.photosToPrint!.count))})
		}
	}
	
	func handleHeaderViewEvents(headerEvent: HeaderViewEvents){
		switch headerEvent {
		case .initState(let arrange):
			_ = Observable.zip(navigationRepository.setViewArrange(arrange: arrange)
				.do(onNext:{_ in self.headerState = self.headerState.with(arrange: Storage.currentArrange)}),
							   photosToPrintRepository.getPhotosToPrint().map{photos -> HeaderState in
								self.headerState = self.headerState.with(photos: photos)
								return self.headerState
			},resultSelector: { _, header in (header)})
				.subscribe(onNext: {headerState in self.state.onNext(HeaderViewViewStates.updateFolderIcon(numberOfPhotos: headerState.photosToPrint?.count ?? 0))
					self.state.onNext(FamiliesViewStates.SwitchViewStyle(currentArrange: headerState.currentArrange))
				})
		case .switchViewStyleClicked:
			_ = navigationRepository.changeViewArrange()
				.map{arrange -> HeaderState in
					self.headerState = self.headerState.with(arrange: arrange)
					return self.headerState
			}
				.subscribe(onNext: {headerState in self.state.onNext(FamiliesViewStates.SwitchViewStyle(currentArrange: headerState.currentArrange))})
			
		case .searchBarClicked:
			state.onNext(HeaderViewViewStates.toSearch)
		case .printPhotosClicked:
			print("print photos clicked")
		}
	}
}
