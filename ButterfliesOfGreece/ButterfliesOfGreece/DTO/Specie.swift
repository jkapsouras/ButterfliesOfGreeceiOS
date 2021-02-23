//
//  Specie.swift
//  ButterfliesOfGreece
//
//  Created by Ioannis Kapsouras on 1/8/20.
//  Copyright © 2020 Ioannis Kapsouras. All rights reserved.
//

import Foundation

struct Specie:Codable {
	var id:Int
	var familyId:Int?
	var name:String
	var imageTitle:String
	var photos:[ButterflyPhoto]
	var isEndangered:Bool?
	var endangeredText:String?
	
	enum CodingKeys: String, CodingKey {
		case id
		case name
		case imageTitle = "imgtitle"
		case photos
		case isEndangered = "endangered"
		case endangeredText = "endangered_text"
	}
}
