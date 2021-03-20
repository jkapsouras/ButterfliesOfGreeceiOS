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
import Photos

class ImageComponent : NSObject, UiComponent, UIImagePickerControllerDelegate, UINavigationControllerDelegate, PHPhotoLibraryChangeObserver
{
	func photoLibraryDidChange(_ changeInstance: PHChange) {
		
	}
	
	var assetCollection: PHAssetCollection!
	var albumFound : Bool = false
	var photosAsset: PHFetchResult<PHAsset>!
	var assetThumbnailSize:CGSize!
	var collection: PHAssetCollection!
	var assetCollectionPlaceholder: PHObjectPlaceholder!
	
	let recognitionView:RecognitionView
	let chooseButton:UIButton
	let takeButton:UIButton
	let liveButton:UIButton
	let owner:UIViewController
	let emitter:PublishSubject<UiEvent> = PublishSubject<UiEvent>()
	let uiEvents: Observable<UiEvent>
	let imagePicker:UIImagePickerController
	let liveView:LiveSession
	
	init(chooseButton:UIButton, takeButton:UIButton, liveButton:UIButton, recognitionView:RecognitionView, liveView:LiveSession, owner:UIViewController) {
		self.owner = owner
		self.recognitionView = recognitionView
		self.chooseButton = chooseButton
		self.takeButton = takeButton
		self.liveButton = liveButton
		self.liveView = liveView
		
		uiEvents = Observable.merge(chooseButton.rx.tap.map{_ in RecognitionEvents.choosePhotoClicked},
									takeButton.rx.tap.map{_ in RecognitionEvents.takePhotoClicked},
									liveButton.rx.tap.map{_ in RecognitionEvents.liveRecognitionClicked},
									recognitionView.UiEvents,
									liveView.UiEvents,
									emitter.asObservable())
		
		imagePicker =  UIImagePickerController()
		imagePicker.allowsEditing = true
		super.init()
		
		imagePicker.delegate = self
		
	}
	
	func createAlbumAndSaveImage(imageToSave: UIImage, name: String) {
		//Get PHFetch Options
		let fetchOptions = PHFetchOptions()
		fetchOptions.predicate = NSPredicate(format: "title = %@", name)
		let collection : PHFetchResult = PHAssetCollection.fetchAssetCollections(with: .album, subtype: .any, options: fetchOptions)
		//Check return value - If found, then get the first album out
		if let _: AnyObject = collection.firstObject {
			self.albumFound = true
			assetCollection = collection.firstObject as! PHAssetCollection
			saveImage(image: imageToSave)
		} else {
			//If not found - Then create a new album
			PHPhotoLibrary.shared().performChanges({
				let createAlbumRequest : PHAssetCollectionChangeRequest = PHAssetCollectionChangeRequest.creationRequestForAssetCollection(withTitle: name)
				self.assetCollectionPlaceholder = createAlbumRequest.placeholderForCreatedAssetCollection
			}, completionHandler: { success, error in
				self.albumFound = success
				
				if (success) {
					let collectionFetchResult = PHAssetCollection.fetchAssetCollections(withLocalIdentifiers: [self.assetCollectionPlaceholder.localIdentifier], options: nil)
					print(collectionFetchResult)
					self.assetCollection = collectionFetchResult.firstObject as! PHAssetCollection
					self.saveImage(image: imageToSave)
				}
			})
		}
	}
	
	func saveImage(image: UIImage){
		PHPhotoLibrary.shared().performChanges({
			let assetRequest = PHAssetChangeRequest.creationRequestForAsset(from: image)
			let assetPlaceholder = assetRequest.placeholderForCreatedAsset
			self.photosAsset = PHAsset.fetchAssets(in: self.assetCollection, options: nil)
			let albumChangeRequest = PHAssetCollectionChangeRequest(for: self.assetCollection, assets: self.photosAsset)
			albumChangeRequest!.addAssets([assetPlaceholder!] as NSFastEnumeration)
		}, completionHandler: { success, error in
			if let error = error {
				// we got back an error!
				DispatchQueue.main.async {
					let ac = UIAlertController(title: Translations.SaveError, message: error.localizedDescription, preferredStyle: .alert)
				ac.addAction(UIAlertAction(title:  Translations.Ok, style: .default))
				self.owner.present(ac, animated: true)
				}
			} else {
				DispatchQueue.main.async {
					let ac = UIAlertController(title: Translations.Saved, message: Translations.SavedMessage, preferredStyle: .alert)
					ac.addAction(UIAlertAction(title: Translations.Ok, style: .default))
				self.owner.present(ac, animated: true)
				}
			}
		})
	}
	
	func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
		imagePicker.dismiss(animated: true, completion: nil)
		guard let selectedImage = info[.editedImage] as? UIImage else {
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
					owner.present(imagePicker, animated: true, completion: nil)
				case .showRecognitionView(let image):
					recognitionView.alpha = 1
					recognitionView.showSelectedImage(image: image)
				case .imageRecognized(let predictions):
					recognitionView.hideLoading()
					recognitionView.imageRecognized(predictions: predictions)
				case .recognitionStarted:
					recognitionView.showLoading()
				case .closeRecognitionView:
					recognitionView.hideLoading()
					recognitionView.alpha = 0
					recognitionView.showSelectedImage(image: UIImage())
				case .showLiveRecognitionView:
					liveView.alpha = 1
					liveView.setupSession()
				case .liveImageRecognized(let predictions, let inferences, let size):
//					if(predictions.count==0)
//					{
//						liveView.hideSaveButton()
//						liveView.ClearDraws()
//						return 
//					}
//					let string = predictions[0].butterflyClass
					let max = inferences.max { a, b in a.confidence > b.confidence }
					if(inferences.isEmpty || (max?.confidence ?? 0) < 0.5){
						liveView.hideSaveButton()
						liveView.ClearDraws()
					}
					else{
						liveView.showSaveButton()
						liveView.drawAfterPerformingCalculations(onInferences: inferences, withImageSize: size)
					}
				case .closeLiveRecognitionView:
					liveView.stopSession()
					liveView.alpha = 0
				case .imageSaved(let image, let name):
					print("image saved")
//					UIImageWriteToSavedPhotosAlbum(image, self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)
					createAlbumAndSaveImage(imageToSave: image, name: name)
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
