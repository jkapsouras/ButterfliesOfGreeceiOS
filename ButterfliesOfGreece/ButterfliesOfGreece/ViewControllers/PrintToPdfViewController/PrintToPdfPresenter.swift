//
//  PrintToPdfPresenter.swift
//  ButterfliesOfGreece
//
//  Created by Ioannis Kapsouras on 13/9/20.
//  Copyright © 2020 Ioannis Kapsouras. All rights reserved.
//

import Foundation
import RxSwift

class PrintToPdfPresenter:BasePresenter{
	
	var photosToPdfState:PhotosToPdfState
	var photosToPrintRepository:PhotosToPrintRepository
	
	init(mainThread:MainThreadProtocol,backgroundThread:BackgroundThreadProtocol,
		 photosToPrintRepository:PhotosToPrintRepository){
		self.photosToPdfState = PhotosToPdfState(photos: [ButterflyPhoto](), pdfArrange: PdfArrange.onePerPage)
		self.photosToPrintRepository = photosToPrintRepository
		super.init(backScheduler: backgroundThread, mainScheduler: mainThread)
	}
	
	override func setupEvents() {
		self.emitter.onNext(PrintToPdfEvents.loadPhotos)
	}
	
	override func HandleEvent(uiEvents: UiEvent) {
		switch uiEvents {
		case let printToPdfEvents as PrintToPdfEvents:
			handlePrintToPdfEvents(printToPdfEvents: printToPdfEvents)
		default:
			state.onNext(GeneralViewState.idle)
		}
	}
	
	func handlePrintToPdfEvents(printToPdfEvents: PrintToPdfEvents){
		switch printToPdfEvents {
		case .loadPhotos:
			_ = photosToPrintRepository.getPhotosToPrint()
				.map{photos -> PhotosToPdfState in
					self.photosToPdfState = self.photosToPdfState.with(photos: photos)
					return self.photosToPdfState}
				.subscribe(onNext: {state in
					self.state.onNext(PrintToPdfViewStates.showPhotos(photos: state.photos))
					self.state.onNext(PrintToPdfViewStates.showNumberOfPhotos(numberOfPhotos: state.photos.count))})
		case .changeArrangeClicked:
			state.onNext(PrintToPdfViewStates.showPickArrangeView(currentArrange: photosToPdfState.pdfArrange))
		case .arrangeSelected(let pdfArrange):
			photosToPdfState = photosToPdfState.with(pdfArrange: pdfArrange)
			state.onNext(PrintToPdfViewStates.arrangeViewChanged(currentArrange: photosToPdfState.pdfArrange))
		}
	}
}
