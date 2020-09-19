//
//  CacheManager.swift
//  ButterfliesOfGreece
//
//  Created by Ioannis Kapsouras on 14/8/20.
//  Copyright © 2020 Ioannis Kapsouras. All rights reserved.
//

import Foundation
import RxSwift

protocol CacheManagerProtocol
{
	var photosToPrint:String { get }
	var _prefs:UserDefaults { get }
	var contributionItems:String { get }
	
	func  savePhotosToPrint(photos:[ButterflyPhoto]) -> Observable<Bool>
	func  getPhotosToPrint() -> Observable<[ButterflyPhoto]>
	func  Clear() -> Observable<Bool>
	func delete(photo:ButterflyPhoto) -> Observable<[ButterflyPhoto]>
	func saveContributionItem(item:ContributionItem) -> Observable<Bool>
	func getContributionItems() -> Observable<[ContributionItem]>
	func deleteContributionItems() -> Observable<Bool>
}

struct CacheManager:CacheManagerProtocol
{
	var photosToPrint: String = "photosToPrint"
	var contributionItems: String = "contributionItems"
	var _prefs: UserDefaults
	
	init(userDefaults: UserDefaults)
	{
		_prefs = userDefaults
	}
	
	func savePhotosToPrint(photos:[ButterflyPhoto]) -> Observable<Bool> {
		do{
			let encodedData = try NSKeyedArchiver.archivedData(withRootObject: photos, requiringSecureCoding: false)
			return Observable.from(optional: UserDefaults.standard.set(encodedData, forKey: photosToPrint)).do(onNext:{self._prefs.synchronize()}).map({ _ in return true})
		}
		catch{
			print("Unexpected error: \(error).")
			return Observable.from(optional: false)
		}
	}
	
	func getPhotosToPrint() -> Observable<[ButterflyPhoto]> {
		let decoded = _prefs.data(forKey: photosToPrint)
		guard let decodedF = decoded else{
			return Observable.from(optional: [ButterflyPhoto]())
		}
		let decodedPhotos = try! NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(decodedF)
		var tempPhotos = decodedPhotos as? [ButterflyPhoto]
		if tempPhotos == nil{
			tempPhotos = [ButterflyPhoto]()
		}
		return Observable.from(optional:  tempPhotos)
	}
	
	func saveContributionItem(item: ContributionItem) -> Observable<Bool> {
		return getContributionItems().map{items -> [ContributionItem] in
			var newItems = items
			newItems.append(item)
			return newItems
		}.map{items -> Bool in
			do{
				let encodedData = try NSKeyedArchiver.archivedData(withRootObject: items, requiringSecureCoding: false)
				UserDefaults.standard.set(encodedData, forKey: contributionItems)
				return true
			}
			catch{
				print("Unexpected error: \(error).")
				return false
			}
		}
		.do(onNext:{_ in self._prefs.synchronize()})
	}
	
	func getContributionItems() -> Observable<[ContributionItem]>{
		let decoded = _prefs.data(forKey: contributionItems)
		guard let decodedF = decoded else{
			return Observable.from(optional: [ContributionItem]())
		}
		let decodedItems = try! NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(decodedF)
		var tempItems = decodedItems as? [ContributionItem]
		if tempItems == nil{
			tempItems = [ContributionItem]()
		}
		return Observable.from(optional:  tempItems)
	}
	
	func delete(photo:ButterflyPhoto) -> Observable<[ButterflyPhoto]> {
		return getPhotosToPrint().map{photos in
			let newPhotos = photos.filter{ph in !(ph.familyId == photo.familyId && ph.specieId == photo.specieId && ph.id == photo.id)}
			return newPhotos
		}
		.do(onNext: {photos in _ = self.savePhotosToPrint(photos: photos)})
	}
	
	func deleteContributionItems() -> Observable<Bool> {
		_prefs.removeObject(forKey: contributionItems)
		return Observable.from(optional: true);
	}
	
	func Clear() -> Observable<Bool> {
		_prefs.removeObject(forKey: photosToPrint)
		return Observable.from(optional: true);
	}
}
