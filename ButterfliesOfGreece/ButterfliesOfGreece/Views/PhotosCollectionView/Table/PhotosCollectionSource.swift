//
//  PhotosCollectionSource.swift
//  ButterfliesOfGreece
//
//  Created by Ioannis Kapsouras on 11/8/20.
//  Copyright © 2020 Ioannis Kapsouras. All rights reserved.
//

import Foundation
import UIKit
import RxSwift

enum ShowingStep{
	case families
	case species
	case photos
	case photosToPrint
}

class PhotosCollectionSource : NSObject, UICollectionViewDataSource, UICollectionViewDelegate{
	var families:[Family] = []
	var species:[Specie] = []
	var photos:[ButterflyPhoto] = []
	var showingStep = ShowingStep.families
	let emitter = PublishSubject<UiEvent>()
	var emitterObs:Observable<UiEvent> {get {return emitter.asObservable()}}
	
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		switch showingStep {
		case .families:
			return families.count
		case .species:
			return species.count
		case .photos,
			 .photosToPrint:
			return photos.count
		}
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotosCollectionViewCell.Key, for: indexPath) as! PhotosCollectionViewCell
		switch showingStep {
		case .families:
			cell.update(family: (families[indexPath.row]), emitter: emitter, showingStep: showingStep)
		case .species:
			cell.update(specie: (species[indexPath.row]), emitter: emitter, showingStep: showingStep)
		case .photos,
			 .photosToPrint:
			cell.update(photo: (photos[indexPath.row]), emitter: emitter, showingStep: showingStep)
		}
		
		return cell
	}
	
	func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
		if let cell = cell as? PhotosCollectionViewCell{
			cell.addRecognizers()
		}
	}
	
	func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
		if let cell = cell as? PhotosCollectionViewCell{
			cell.removeRecognizers()
		}
	}
	
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		switch showingStep {
		case .families:
			emitter.onNext(FamiliesEvents.familyClicked(id: families[indexPath.row].id))
		case .species:
			emitter.onNext(SpeciesEvents.specieClicked(id: species[indexPath.row].id))
		case .photos:
			emitter.onNext(PhotosEvents.photoClicked(id: photos[indexPath.row].id))
		case .photosToPrint:
			break
		}
	}
	
	func setFamilies(families: [Family]){
		self.families = families
	}
	
	func setSpecies(species: [Specie]){
		self.species = species
	}
	
	func setPhotos(photos: [ButterflyPhoto]){
		self.photos = photos
	}
	
	func setShowingStep(showingStep:ShowingStep){
		self.showingStep = showingStep
	}
}
