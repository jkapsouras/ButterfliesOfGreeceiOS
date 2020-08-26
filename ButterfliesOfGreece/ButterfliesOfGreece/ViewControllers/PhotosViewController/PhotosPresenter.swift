//
//  PhotosPresenter.swift
//  ButterfliesOfGreece
//
//  Created by Ioannis Kapsouras on 23/8/20.
//  Copyright © 2020 Ioannis Kapsouras. All rights reserved.
//

import Foundation
import RxSwift

class PhotosPresenter:BasePresenter{
	
	var photosState:PhotosState
	var headerState:HeaderState
	var photosRepository:PhotosRepository
	var navigationRepository:NavigationRepository
	var photosToPrintRepository:PhotosToPrintRepository
	
	init(mainThread:MainThreadProtocol,backgroundThread:BackgroundThreadProtocol,
		 photosRepository:PhotosRepository, navigationRepository:NavigationRepository,
		 photosToPrintRepository:PhotosToPrintRepository)
	{
		self.photosRepository = photosRepository
		self.photosToPrintRepository = photosToPrintRepository
		self.navigationRepository = navigationRepository
		photosState = PhotosState(photos: [ButterflyPhoto](), indexOfSelectedPhoto: -1)
		headerState = HeaderState(currentArrange: .grid, photosToPrint: nil, headerName: "Photos")
		super.init(backScheduler: backgroundThread, mainScheduler: mainThread)
	}
	
	override func setupEvents() {
		_ = Observable.zip(navigationRepository.getSpecieId(),navigationRepository.getViewArrange(),resultSelector: {id, arrange in (id, arrange)})
			.subscribe(onNext: {data in
				self.emitter.onNext(PhotosEvents.loadPhotos(specieId: data.0))
				self.emitter.onNext(HeaderViewEvents.initState(currentArrange: data.1))})
	}
	
	override func HandleEvent(uiEvents uiEvent: UiEvent) {
		switch uiEvent {
		case let photosEvent as PhotosEvents:
			handlePhotosEvents(photosEvent: photosEvent)
		case let headerEvent as HeaderViewEvents:
			handleHeaderViewEvents(headerEvent: headerEvent)
		default:
			state.onNext(GeneralViewState.idle)
		}
	}
	
	func handlePhotosEvents(photosEvent: PhotosEvents){
		switch photosEvent {
			case .photoClicked(let photoId):
				state.onNext(PhotosViewStates.ToPhoto(photoId: photoId))
			case .loadPhotos(let specieId):
				_ = Observable.zip(photosRepository.getSelectedSpecieName(specieId: specieId).map{specieName -> HeaderState in
					self.headerState = self.headerState.with(headerName: specieName)
					return self.headerState
					},
					photosRepository.getPhotosOfSpecie(specieId: specieId).map{photos -> PhotosState in
					self.photosState = self.photosState.with(photos: photos)
					return self.photosState
				}, resultSelector: {headerState, photosState in (headerState, photosState)})
					.subscribe(onNext: {data in
						self.state.onNext(HeaderViewViewStates.setHeaderTitle(headerTitle: data.0.headerName))
						self.state.onNext(PhotosViewStates.ShowPhotos(photos: data.1.photos))})
			case .addPhotoForPrintClicked(let photoId):
				_ = photosToPrintRepository
					.getPhotosToPrint()
					.map{photos in return self.updateHeaderState(photos: photos, photoId: photoId)}
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
					self.state.onNext(PhotosViewStates.SwitchViewStyle(currentArrange: headerState.currentArrange))
					
				})
			case .switchViewStyleClicked:
				headerState = headerState.with(arrange: headerState.currentArrange.changeArrange())
				state.onNext(PhotosViewStates.SwitchViewStyle(currentArrange: headerState.currentArrange))
			case .searchBarClicked:
				print("search bar clicked")
			case .printPhotosClicked:
				print("print photos clicked")
		}
	}
	
	func updateHeaderState(photos:[ButterflyPhoto], photoId:Int) -> HeaderState{
		headerState = headerState.with(photos: photos)
		let photo = photosState.photos.first{$0.id == photoId}
		var photos : [ButterflyPhoto]?
		photos = [ButterflyPhoto]()
		photos?.append(photo!)
		headerState = headerState.with(photos:photos)
		return headerState
	}
}
