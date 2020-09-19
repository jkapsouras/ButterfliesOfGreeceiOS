//
//  PdfPreviewPresenter.swift
//  ButterfliesOfGreece
//
//  Created by Ioannis Kapsouras on 16/9/20.
//  Copyright © 2020 Ioannis Kapsouras. All rights reserved.
//

import Foundation
import RxSwift

class PdfPreviewPresenter:BasePresenter{
	
	var pdfState:PdfPreviewState
	var photosToPrintRepository:PhotosToPrintRepository
	var pdfCreator:PdfManager
	
	init(mainThread:MainThreadProtocol,backgroundThread:BackgroundThreadProtocol,
		 photosToPrintRepository:PhotosToPrintRepository){
		self.pdfState = PdfPreviewState(pdfData: nil, photos: [ButterflyPhoto](), pdfArrange: PdfArrange.onePerPage)
		self.photosToPrintRepository = photosToPrintRepository
		pdfCreator = PdfManager()
		super.init(backScheduler: backgroundThread, mainScheduler: mainThread)
	}
	
	override func setupEvents() {
		_ = Observable.zip(photosToPrintRepository.getPdfArrange(), photosToPrintRepository.getPhotosToPrint(),resultSelector: {pdfArrange, photos in (pdfArrange, photos)})
			.subscribeOn(backgroundThreadScheduler.scheduler)
			.map{data -> PdfPreviewState in
				self.state.onNext(GeneralViewState.idle)
				self.pdfState = self.pdfState.with(pdfData: self.pdfCreator.createPhotosBook(photos: data.1, pdfArrange: data.0), photos: data.1, pdfArrange: data.0)
				return self.pdfState
		}
			.subscribe(onNext: {data in
				self.state.onNext(PdfPreviewViewStates.showPdf(pdfData: self.pdfState.pdfData!))
			})
	}
	
	override func HandleEvent(uiEvents: UiEvent) {
		switch uiEvents {
		case let previewPdfEvents as PdfPreviewEvents:
			switch previewPdfEvents {
			case .sharePdf:
				state.onNext(PdfPreviewViewStates.showShareDialog(pdfData: pdfState.pdfData ?? Data()))
			}
		default:
			state.onNext(GeneralViewState.idle)
		}
	}
}
