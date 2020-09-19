//
//  ContributionItem.swift
//  ButterfliesOfGreece
//
//  Created by Ioannis Kapsouras on 19/9/20.
//  Copyright © 2020 Ioannis Kapsouras. All rights reserved.
//

import Foundation

class ContributionItem:NSObject, NSCoding, Codable{
	let name:String?
	let date:String?
	let altitude:String?
	let place:String?
	let longitude:String?
	let latitude:String?
	let stage:String?
	let genusSpecies:String?
	let nameSpecies:String?
	let comments:String?
	
	func encode(with coder: NSCoder) {
		coder.encode (name, forKey: "name")
		coder.encode (date, forKey: "date")
		coder.encode (altitude, forKey: "altitude")
		coder.encode (place, forKey: "place")
		coder.encode (longitude, forKey: "longitude")
		coder.encode (latitude, forKey: "latitude")
		coder.encode (stage, forKey: "stage")
		coder.encode (genusSpecies, forKey: "genusSpecies")
		coder.encode (nameSpecies, forKey: "nameSpecies")
		coder.encode (comments, forKey: "comments")
	}
	
	required init?(coder: NSCoder) {
		name = coder.decodeObject(forKey: "name") as? String
		date = coder.decodeObject (forKey: "date") as? String
		altitude = coder.decodeObject (forKey: "altitude") as? String
		place = coder.decodeObject (forKey: "place") as? String
		longitude = coder.decodeObject (forKey: "longitude") as? String
		latitude = coder.decodeObject(forKey: "latitude") as? String
		stage = coder.decodeObject(forKey: "stage") as? String
		genusSpecies = coder.decodeObject(forKey: "genusSpecies") as? String
		nameSpecies = coder.decodeObject(forKey: "nameSpecies") as? String
		comments = coder.decodeObject(forKey: "comments") as? String
	}
	
	init(name:String?, date:String?, altitude:String?, place:String?, longitude:String?, latitude:String?, stage:String?, genusSpecies:String?, nameSpecies:String?, comments: String?) {
		self.name = name
		self.date = date
		self.altitude = altitude
		self.place = place
		self.longitude = longitude
		self.latitude = latitude
		self.stage = stage
		self.genusSpecies = genusSpecies
		self.nameSpecies = nameSpecies
		self.comments = comments
	}
	
	override init(){
		name = ""
		date = ""
		altitude = ""
		place = ""
		longitude = ""
		latitude = ""
		stage = ""
		genusSpecies = ""
		nameSpecies = ""
		comments = ""
	}
	
	func with(name:String? = nil, date:String? = nil, altitude:String? = nil, place:String? = nil, longitude:String? = nil, latitude:String? = nil, stage:String? = nil, genusSpecies:String? = nil, nameSpecies:String? = nil, comments: String? = nil) -> ContributionItem{
		return ContributionItem(name: name ?? self.name,
								date: date ?? self.date,
								altitude: altitude ?? self.altitude,
								place: place ?? self.place,
								longitude: longitude ?? self.longitude,
								latitude: latitude ?? self.latitude,
								stage: stage ?? self.stage,
								genusSpecies: genusSpecies ?? self.genusSpecies,
								nameSpecies: nameSpecies ?? self.nameSpecies,
								comments: comments ?? self.comments)
	}
}
