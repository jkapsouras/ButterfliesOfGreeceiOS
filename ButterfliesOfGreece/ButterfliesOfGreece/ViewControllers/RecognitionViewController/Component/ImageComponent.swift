//
//  ImageComponent.swift
//  ButterfliesOfGreece
//
//  Created by Apprecot on 25/9/20.
//  Copyright © 2020 Ioannis Kapsouras. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class ImageComponent : NSObject, UiComponent, UIImagePickerControllerDelegate, UINavigationControllerDelegate
{
	let recognitionView:RecognitionView
	let chooseButton:UIButton
	let takeButton:UIButton
	let owner:UIViewController
	let emitter:PublishSubject<UiEvent> = PublishSubject<UiEvent>()
	let uiEvents: Observable<UiEvent>
	let imagePicker:UIImagePickerController
	
	init(chooseButton:UIButton, takeButton:UIButton, recognitionView:RecognitionView, owner:UIViewController) {
		self.owner = owner
		self.recognitionView = recognitionView
		self.chooseButton = chooseButton
		self.takeButton = takeButton
		
		uiEvents = Observable.merge(chooseButton.rx.tap.map{_ in RecognitionEvents.choosePhotoClicked},
									takeButton.rx.tap.map{_ in RecognitionEvents.takePhotoClicked},
									recognitionView.ViewEvents(),
									emitter.asObservable())
		
		imagePicker =  UIImagePickerController()
		super.init()
		
		imagePicker.delegate = self
	}
	
	func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
		imagePicker.dismiss(animated: true, completion: nil)
		guard let selectedImage = info[.originalImage] as? UIImage else {
			print("Image not found!")
			return
		}
		emitter.onNext(RecognitionEvents.photoChoosed(image: selectedImage))
	}
	
	public func renderViewState(viewState: ViewState) {
		if let state = viewState as? RecognitionViewStates{
			switch state {
				case .showGallery:
					imagePicker.sourceType = .photoLibrary
					owner.present(imagePicker, animated: true, completion: nil)
				case .showCamera:
					imagePicker.sourceType = .camera
					imagePicker.allowsEditing = false
					owner.present(imagePicker, animated: true, completion: nil)
				case .showRecognitionView(let image):
					recognitionView.alpha = 1
					recognitionView.showSelectedImage(image: image)
				case .imageRecognized(let predictions):
					recognitionView.hideLoading()
					recognitionView.imageRecognized(predictions: predictions)
				case .recognitionStarted:
					recognitionView.showLoading()
				default:
					print("something else")
			}
		}
		if let state = viewState as? GeneralViewState{
			switch state {
				case .idle:
					print("start loading")
			}
		}
	}
}
