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
	var cacheManager:CacheManagerProtocol
	
	init(mainThread:MainThreadProtocol,backgroundThread:BackgroundThreadProtocol, cacheManager:CacheManagerProtocol)
	{
		self.cacheManager = cacheManager
		familiesState = FamiliesState()
		headerState = HeaderState(arrange: .grid)
		super.init(backScheduler: backgroundThread, mainScheduler: mainThread)
	}
	
	override func HandleEvent(uiEvents uiEvent: UiEvent) {
		switch uiEvent {
		case let familyEvent as FamiliesEvents:
			switch familyEvent {
			case .familyClicked(let familyId):
				state.onNext(FamiliesViewStates.ToSpecies(familyId: familyId))
			case .loadFamilies:
				state.onNext(FamiliesViewStates.ShowFamilies(families: familiesState.families))
			case .addPhotosForPrintClicked(let familyId):
				cacheManager.getPhotosToPrint().map{photos in return self.updateHeaderState(photos: photos, familyId: familyId)}.subscribe(onNext: {count in self.state.onNext(HeaderViewViewStates.updateFolderIcon(numberOfPhotos: count))}).dispose()
			}
		case let headerEvent as HeaderViewEvents:
			switch headerEvent {
			case .switchViewStyleClicked:
				headerState.currentArrange = headerState.currentArrange.changeArrange()
				state.onNext(FamiliesViewStates.SwitchViewStyle(currentArrange: headerState.currentArrange))
			case .searchBarClicked:
				print("search bar clicked")
			case .printPhotosClicked:
				print("print photos clicked")
			case .initPhotosToPrint:
				cacheManager.getPhotosToPrint().map{photos in return self.setupHeaderState(photos: photos)}.subscribe(onNext: {count in self.state.onNext(HeaderViewViewStates.updateFolderIcon(numberOfPhotos: count))}).dispose()
			}
		default:
			state.onNext(GeneralViewState.idle)
		}
	}
	
	func setupHeaderState(photos:[ButterflyPhoto]) -> Int{
		headerState.photosToPrint = photos
		return photos.count
	}
	
	func updateHeaderState(photos:[ButterflyPhoto], familyId:Int) -> Int{
		headerState.photosToPrint = photos
		let family = familiesState.families.first{$0.id==familyId}
		let photos = family?.species.flatMap{$0.photos}
		if let _ = headerState.photosToPrint{
			headerState.photosToPrint! += photos ?? [ButterflyPhoto]()
		}
		return headerState.photosToPrint?.count ?? 0
	}
}
