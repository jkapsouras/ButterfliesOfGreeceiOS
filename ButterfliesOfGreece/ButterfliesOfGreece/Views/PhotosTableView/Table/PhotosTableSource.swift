//
//  PhotosTableSource.swift
//  ButterfliesOfGreece
//
//  Created by Ioannis Kapsouras on 11/8/20.
//  Copyright © 2020 Ioannis Kapsouras. All rights reserved.
//

import Foundation
import UIKit

class PhotosTableSource : NSObject, UITableViewDataSource, UITableViewDelegate
{
	var families:[Family] = []
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: PhotosTableViewCell.Key, for: indexPath) as! PhotosTableViewCell
		cell.update(family: (families[indexPath.row]))
		return cell
	}
	
//	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//		LocationSelected = _response!.mapItems[indexPath.row].placemark
//		_owner?.ClosePlaces(mapItem: (_response?.mapItems[indexPath.row])!);
//		_owner?.DismissView();
////		tableView.FadeOut();
//		tableView.alpha=0
//	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return families.count
	}
	
	func setFamilies(families: [Family]){
		self.families = families
	}
}

