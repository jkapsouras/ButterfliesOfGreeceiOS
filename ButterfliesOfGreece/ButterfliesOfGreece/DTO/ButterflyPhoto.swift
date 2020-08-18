//
//  ButterflyPhoto.swift
//  ButterfliesOfGreece
//
//  Created by Ioannis Kapsouras on 1/8/20.
//  Copyright © 2020 Ioannis Kapsouras. All rights reserved.
//

import Foundation

class ButterflyPhoto:NSObject, NSCoding, Codable{
	enum Genre: String, Codable{
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
	
	func encode(with coder: NSCoder) {
		coder.encode (id, forKey: "id")
        coder.encode (source, forKey: "src")
        coder.encode (title, forKey: "title")
		coder.encode (author, forKey: "author")
		coder.encode (genre, forKey: "genre")
		coder.encode (identified, forKey: "iden")
	}
	
	required init?(coder: NSCoder) {
		id = coder.decodeInteger(forKey: "id")
        source = coder.decodeObject (forKey: "src") as! String
        title = coder.decodeObject (forKey: "title") as! String
		author = coder.decodeObject (forKey: "author") as! String
		genre = coder.decodeObject (forKey: "genre") as! Genre
		identified = coder.decodeBool(forKey: "iden")
	}
	
	override init(){
		id = -1
		source = ""
		title = ""
		author = ""
		genre = .F
		identified = false
	}
}

