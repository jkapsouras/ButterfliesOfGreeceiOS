//
//  ModalPresenter.swift
//  ButterfliesOfGreece
//
//  Created by Ioannis Kapsouras on 26/8/20.
//  Copyright © 2020 Ioannis Kapsouras. All rights reserved.
//

import Foundation
import RxSwift

class ModalPresenter:BasePresenter{
	
	var photosState:PhotosState
	var photosRepository:PhotosRepository
	var navigationRepository:NavigationRepository
	
	init(mainThread:MainThreadProtocol,backgroundThread:BackgroundThreadProtocol,
		 photosRepository:PhotosRepository, navigationRepository:NavigationRepository)
	{
		self.photosRepository = photosRepository
		self.navigationRepository = navigationRepository
		photosState = PhotosState(photos: [ButterflyPhoto](), indexOfSelectedPhoto: -1)
		super.init(backScheduler: backgroundThread, mainScheduler: mainThread)
	}
	
	override func setupEvents() {
		_ = Observable.zip(navigationRepository.getSpecieId(),navigationRepository.getPhotoId(),resultSelector: {specieId, photoId in (specieId, photoId)})
			.subscribe(onNext: {data in
				self.emitter.onNext(ModalEvents.loadPhotos(specieId: data.0, photoId: data.1))
			})
	}
	
	override func HandleEvent(uiEvents uiEvent: UiEvent) {
		switch uiEvent {
		case let modalEvent as ModalEvents:
			handleModalEvents(modalEvent: modalEvent)
		default:
			state.onNext(GeneralViewState.idle)
		}
	}
	
	func handleModalEvents(modalEvent: ModalEvents){
		switch modalEvent {
		case .loadPhotos(let specieId,let photoId):
			_ = photosRepository.getPhotosOfSpecie(specieId: specieId).map{photos -> PhotosState in
				self.photosState = self.photosState.with(photos: photos, photoId: photoId)
				return self.photosState}
				.subscribe(onNext: {data in
					self.state.onNext(ModalViewStates.ShowPhotosStartingWith(index: data.indexOfSelectedPhoto, photos: data.photos.compactMap{$0.source}))})
		}
	}
}
