//
//  PhotosCollectionSource.swift
//  ButterfliesOfGreece
//
//  Created by Ioannis Kapsouras on 11/8/20.
//  Copyright © 2020 Ioannis Kapsouras. All rights reserved.
//

import Foundation
import UIKit

class PhotosCollectionSource : NSObject, UICollectionViewDataSource, UICollectionViewDelegate{
	var families:[Family] = []
	
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return families.count
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotosCollectionViewCell.Key, for: indexPath) as! PhotosCollectionViewCell
		cell.update(family: (families[indexPath.row]))
		return cell
	}
	
	func setFamilies(families: [Family]){
		self.families = families
	}
}
