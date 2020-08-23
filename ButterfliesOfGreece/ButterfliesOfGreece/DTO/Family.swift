//
//  Family.swift
//  ButterfliesOfGreece
//
//  Created by Ioannis Kapsouras on 1/8/20.
//  Copyright © 2020 Ioannis Kapsouras. All rights reserved.
//

import Foundation

struct Family:Codable{
	var id:Int
	var name:String
	var photo:String
	var species:[Specie]
	
	enum CodingKeys: String, CodingKey {
		case id
		case name
		case photo
		case species="spieces"
	}
}
