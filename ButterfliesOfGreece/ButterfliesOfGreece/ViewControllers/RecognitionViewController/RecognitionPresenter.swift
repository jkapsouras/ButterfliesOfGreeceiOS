//
//  File.swift
//  ButterfliesOfGreece
//
//  Created by Apprecot on 25/9/20.
//  Copyright © 2020 Ioannis Kapsouras. All rights reserved.
//

import Foundation
import RxSwift

class RecognitionPresenter:BasePresenter{
	
	var recognitionState:RecognitionState
	var recognitionRepository:RecognitionRepository
	let compressionQuality:CGFloat = 0.7
	private var modelDataHandler: ModelDataHandler? =
		ModelDataHandler(modelFileInfo: MobileNet.modelInfo, labelsFileInfo: MobileNet.labelsInfo, threadCount: 2)
	
	init(mainThread:MainThreadProtocol,backgroundThread:BackgroundThreadProtocol,
		 recognitionRepository:RecognitionRepository){
		self.recognitionRepository = recognitionRepository
		recognitionState = RecognitionState(image: nil, imageData: nil, predictions: [Prediction]())
		super.init(backScheduler: backgroundThread, mainScheduler: mainThread)
	}
	
	override func setupEvents() {
		
	}
	
	override func HandleEvent(uiEvents: UiEvent) {
		switch uiEvents {
			case let recognitionEvent as RecognitionEvents:
				handleRecognitionEvents(recognitionEvent: recognitionEvent)
			default:
				state.onNext(GeneralViewState.idle)
		}
	}
	
	func handleRecognitionEvents(recognitionEvent: RecognitionEvents){
		switch recognitionEvent {
			case .choosePhotoClicked:
				state.onNext(RecognitionViewStates.showGallery)
			case .takePhotoClicked:
				state.onNext(RecognitionViewStates.showCamera)
			case .onlineClicked:
				Observable.of(1).startWith(1).take(1).map{_ in self.state.onNext(RecognitionViewStates.recognitionStarted)}
					.flatMap{_ in self.recognitionRepository.recognize(image: Avatar(avatar: self.recognitionState.imageData!))}
					.subscribeOn(backgroundThreadScheduler.scheduler)
					.subscribe(onNext: {predictions in
						self.recognitionState = self.recognitionState.with(predictions:predictions.predictions)
						self.state.onNext(RecognitionViewStates.imageRecognized(predictions: self.recognitionState.predictions))
					}, onError: {error in print(error.localizedDescription)}).disposed(by: disposeBag!)
			case .offlineClicked:
				let image = recognitionState.image
				guard let buffer = CVImageBuffer.buffer(from: image!) else {
					return
				}
				Observable.of(1).startWith(1).take(1).map{_ in
					self.modelDataHandler?.runModel(onFrame: buffer)}
					.subscribeOn(backgroundThreadScheduler.scheduler)
					.map{result -> RecognitionState in
						self.recognitionState = self.recognitionState.with(predictions: result?.to().predictions ?? [Prediction]())
						return self.recognitionState
					}
					.subscribe(onNext: {state in
						self.state.onNext(RecognitionViewStates.imageRecognized(predictions: self.recognitionState.predictions))
					}, onError: {error in print(error.localizedDescription)})
					.disposed(by: disposeBag!)
			case .photoChoosed(let selectedImage):
				guard let imageData = selectedImage.jpegData(compressionQuality: compressionQuality) else{
					print("data did not creted")
					return
				}
				recognitionState = recognitionState.with(image: selectedImage, imageData: imageData)
				state.onNext(RecognitionViewStates.showRecognitionView(image: recognitionState.image!))
			case .photoTaken(let selectedImage):
				guard let imageData = selectedImage.jpegData(compressionQuality: compressionQuality) else{
					print("data did not creted")
					return
				}
				recognitionState = recognitionState.with(image: selectedImage, imageData: imageData)
				state.onNext(RecognitionViewStates.showRecognitionView(image: recognitionState.image!))
			case .liveRecognitionClicked:
				state.onNext(RecognitionViewStates.showLiveRecognitionView)
			case .closeClicked:
				state.onNext(RecognitionViewStates.closeRecognitionView)
			case .liveImageTaken(let image):
				Observable.of(1).startWith(1).take(1)
					.map{result -> RecognitionState in
						self.recognitionState = self.recognitionState.with(image: image)
						return self.recognitionState
					}
					.subscribeOn(backgroundThreadScheduler.scheduler)
					.map{state -> Result? in
						let image = state.image
						guard let buffer = CVImageBuffer.buffer(from: image!) else {
							return nil
						}
						return self.modelDataHandler?.runModel(onFrame: buffer)}
					.map{result -> RecognitionState in
						self.recognitionState = self.recognitionState.with(predictions: result?.to().predictions ?? [Prediction]())
						return self.recognitionState
					}
					.subscribe(onNext: {state in
						self.state.onNext(RecognitionViewStates.liveImageRecognized(predictions: state.predictions))
					}, onError: {error in print(error.localizedDescription)})
					.disposed(by: disposeBag!)
			case .closeLiveClicked:
				state.onNext(RecognitionViewStates.closeLiveRecognitionView)
		}
	}
}
