//
//  Storage.swift
//  ButterfliesOfGreece
//
//  Created by Ioannis Kapsouras on 15/8/20.
//  Copyright © 2020 Ioannis Kapsouras. All rights reserved.
//

import Foundation
import RxSwift

struct Storage {
	
	
	lazy var families:[Family] = {
		return self.ReadData(fileName: "data", type: "json")
	}()
	
	private(set) static var currentArrange:ViewArrange = .list
	static var familyId:Int?
	static var specieId:Int?
	static var photoId:Int?
	
	mutating func species(familyId:Int) -> [Specie]{
		return families.filter{$0.id == familyId}.flatMap{$0.species}
	}
	
	mutating func photos(specieId:Int) -> [ButterflyPhoto]{
		return species(familyId: Storage.familyId!).filter{$0.id == specieId}.flatMap{$0.photos}
	}
	
	mutating func getSelectedFamilyName(familyId:Int) -> String{
		return families.first{$0.id == familyId}!.name
	}
	
	mutating func getSelectedSpecieName(specieId:Int) -> String{
		return families.first{$0.id == Storage.familyId!}!.species.first{$0.id == specieId}!.name
	}
	
	mutating func setFamilyId(familyId:Int) -> Observable<Bool>{
		return Observable.from(optional: Storage.familyId = familyId).map({ _ in return true})
	}
	
	func getFamilyId() -> Observable<Int>{
		return Observable.from(optional: Storage.familyId!)
	}
	
	mutating func setSpecieId(specieId:Int) -> Observable<Bool>{
		return Observable.from(optional: Storage.specieId = specieId).map({ _ in return true})
	}
	
	func getSpecieId() -> Observable<Int>{
		return Observable.from(optional: Storage.specieId!)
	}
	
	mutating func setPhotoId(photoId:Int) -> Observable<Bool>{
		return Observable.from(optional: Storage.photoId = photoId).map({ _ in return true})
	}
	
	func getPhotoId() -> Observable<Int>{
		return Observable.from(optional: Storage.photoId!)
	}
	
	mutating func setViewArrange(currentArrange:ViewArrange) -> Observable<Bool>{
		return Observable.from(optional: Storage.currentArrange = currentArrange).map({ _ in return true})
	}
	
	mutating func changeArrange(){
		Storage.currentArrange = Storage.currentArrange.changeArrange()
	}
}

extension Storage{
	func ReadData(fileName:String, type:String)->[Family]{
		let path = Bundle.main.path(forResource: fileName, ofType: type)
		guard path != nil else{
			return [Family]()
		}
		let json = try? String(contentsOfFile: path!)
		guard json != nil else{
			return [Family]()
		}
		let data = json!.data(using: .utf8)
		let decoder = JSONDecoder()
		let families = try? decoder.decode([Family].self, from: data!)
		guard families != nil else{
			return [Family]()
		}
		return families!
	}
}
