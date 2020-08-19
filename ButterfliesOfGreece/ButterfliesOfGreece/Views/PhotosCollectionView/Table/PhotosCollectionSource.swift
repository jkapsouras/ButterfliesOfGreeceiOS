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

class PhotosCollectionSource : NSObject, UICollectionViewDataSource, UICollectionViewDelegate{
	var families:[Family] = []
	let emitter = PublishSubject<UiEvent>()
	var emitterObs:Observable<UiEvent> {get {return emitter.asObservable()}}
	
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return families.count
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotosCollectionViewCell.Key, for: indexPath) as! PhotosCollectionViewCell
		cell.update(family: (families[indexPath.row]), emitter: emitter)
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
	
	func setFamilies(families: [Family]){
		self.families = families
	}
}
