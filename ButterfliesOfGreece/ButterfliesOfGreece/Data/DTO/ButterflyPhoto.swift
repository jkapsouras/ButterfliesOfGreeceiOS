//
//  ButterflyPhoto.swift
//  ButterfliesOfGreece
//
//  Created by Ioannis Kapsouras on 1/8/20.
//  Copyright © 2020 Ioannis Kapsouras. All rights reserved.
//

import Foundation

struct ButterflyPhoto:Codable{
	enum Genre:String, Codable{
		case M
		case F
	}

	var id:Int
	var source:String
	var title:String
	var author:String
	var genre:Genre
	var identified:Bool
	
	enum CodingKeys: String, CodingKey {
		case id
		case source = "src"
		case title
		case author
		case genre
		case identified = "iden"
		
	}
}

