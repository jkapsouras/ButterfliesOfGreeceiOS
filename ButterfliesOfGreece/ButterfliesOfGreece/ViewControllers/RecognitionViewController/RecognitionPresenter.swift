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
	var speciesRepository:SpeciesRepository
	let compressionQuality:CGFloat = 1
	private var modelDataHandler: ModelDataHandler = ModelDataHandler()
	private var detectionModelDataHandler: DetectionModelDataHandler?
	var processing = false
		
	
	init(mainThread:MainThreadProtocol,backgroundThread:BackgroundThreadProtocol,
		 recognitionRepository:RecognitionRepository,
		 speciesRepository:SpeciesRepository){
		self.recognitionRepository = recognitionRepository
		self.speciesRepository = speciesRepository
		recognitionState = RecognitionState(image: nil, imageData: nil, imagePixelBuffer: nil, predictions: [Prediction](), inferences: [DetectionInference]())
		detectionModelDataHandler = DetectionModelDataHandler(modelFileInfo: MobileNetSSD.modelInfo, labelsFileInfo: MobileNetSSD.labelsInfo, threadCount: 2)
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
				let resizedImage = image!.resize(to: CGSize(width: 224, height: 224))
				guard var pixelBuffer = resizedImage.normalized() else {
					return
				}
				Observable.of(1).subscribeOn(backgroundThreadScheduler.scheduler)
					.startWith(1).take(1).map{_ -> [NSNumber]? in
					let outputs = self.modelDataHandler.module.predict(image: UnsafeMutableRawPointer(&pixelBuffer))
					return outputs
					
				}
					.map{result -> RecognitionState in
						let labels = self.modelDataHandler.labels
						let zippedResults = zip(labels.indices, result!)
						let sortedResults = zippedResults.sorted { $0.1.floatValue > $1.1.floatValue }.prefix(3)
						
						var predictions:[Prediction] = [Prediction]()
						var text = ""
						for result in sortedResults {
							print("\(labels[result.0]) \(result.1) ")
							text += "\u{2022} \(labels[result.0]) \n\n"
							predictions.append(Prediction(butterflyClass: labels[result.0], output: result.1.doubleValue, prob: result.1.doubleValue))
						}
						self.recognitionState = self.recognitionState.with(predictions: predictions)
						return self.recognitionState
					}
					.subscribe(onNext: {state in
						self.state.onNext(RecognitionViewStates.imageRecognized(predictions: self.recognitionState.predictions))
					}, onError: {error in print(error.localizedDescription)})
					.disposed(by: disposeBag!)
			case .photoChoosed(let selectedImage):
				guard let imageData = selectedImage.pngData()else{ // .jpegData(compressionQuality: compressionQuality) else{
					print("data did not creted")
					return
				}
				recognitionState = recognitionState.with(image: selectedImage, imageData: imageData)
				state.onNext(RecognitionViewStates.showRecognitionView(image: recognitionState.image!))
			case .photoTaken(let selectedImage):
				guard let imageData = selectedImage.pngData()else{// .jpegData(compressionQuality: compressionQuality) else{
					print("data did not creted")
					return
				}
				recognitionState = recognitionState.with(image: selectedImage, imageData: imageData)
				state.onNext(RecognitionViewStates.showRecognitionView(image: recognitionState.image!))
			case .liveRecognitionClicked:
				state.onNext(RecognitionViewStates.showLiveRecognitionView)
			case .closeClicked:
				state.onNext(RecognitionViewStates.closeRecognitionView)
			case .liveImageTaken(let image, let imagePixelBuffer):
			let obs1 = Observable.of(1).startWith(1).take(1)
					.filter({_ in !self.processing})
					.map{result -> RecognitionState in
						self.recognitionState = self.recognitionState.with(image: image, imagePixelBuffer: imagePixelBuffer)
						return self.recognitionState
					}
					.subscribeOn(backgroundThreadScheduler.scheduler)
					.map{state -> DetectionResult? in
//						let image = state.image
//						let imagePixelBuffer = state.imagePixelBuffer
//						let resizedImage = image!.resized(to: CGSize(width: 224, height: 224))
//						guard var pixelBuffer = resizedImage.normalized() else {
//							return nil
//						}
						self.processing = true
						print("start processing")
						let result = self.detectionModelDataHandler?.runModel(onFrame: imagePixelBuffer!)
//						if(result?.inferences.count ?? 0 > 0)
//						{
//							print("There is a result: \(result?.inferences[0].className)")
//						}
						return result} //self.modelDataHandler.module.predict(image: UnsafeMutableRawPointer(&pixelBuffer))}
					
				Observable.zip(obs1, speciesRepository.getAllSpecies(),
							   resultSelector: { result, species in (result,species)})
							.map{zip -> RecognitionState in
								var infs = zip.0
								print("end processing")
								self.processing=false
//								let labels = self.modelDataHandler.labels
//								let zippedResults = zip(labels.indices, result!)
//								let sortedResults = zippedResults.sorted { $0.1.floatValue > $1.1.floatValue }.prefix(3)
								
								var predictions:[Prediction] = [Prediction]()
//								var text = ""
								if(zip.0?.inferences.count ?? 0 == 0)
								{
									return self.recognitionState.with(predictions: [Prediction](), inferences: [DetectionInference]())
								}
								for  r in infs!.inferences {
									predictions.append(Prediction(butterflyClass: r.className, output: 0, prob: 0))
								}
								var specie:Specie?
								let objIndex = zip.0!.inferences.firstIndex(where: {r in
									specie = zip.1.first{s in s.name.lowercased() == r.className.lowercased()}
									return (specie != nil && specie!.isEndangered != nil && (specie?.isEndangered == true))
								});
								if let i = objIndex
								{
									infs!.inferences[i].className = "\(infs!.inferences[i].className)\n\(specie!.endangeredText!)"
									infs!.inferences[i].displayColor = UIColor.red
								}
								self.recognitionState = self.recognitionState.with(predictions: predictions, inferences: infs!.inferences)
								return self.recognitionState
							}
					.subscribe(onNext: {state in
						let width = CVPixelBufferGetWidth(state.imagePixelBuffer!)
						let height = CVPixelBufferGetHeight(state.imagePixelBuffer!)
						let size = CGSize(width: width, height: height)
						//print(state.inferences[0].className)
						self.state.onNext(RecognitionViewStates.liveImageRecognized(predictions: state.predictions, inferences: state.inferences, imageSize: size))
					}, onError: {error in
						print(error.localizedDescription)})
					.disposed(by: disposeBag!)
			case .closeLiveClicked:
				state.onNext(RecognitionViewStates.closeLiveRecognitionView)
			case .saveImage:
				if let image = recognitionState.image{
						state.onNext(RecognitionViewStates.imageSaved(image: image, name: recognitionState.predictions[0].butterflyClass))
				}
		}
	}
}
