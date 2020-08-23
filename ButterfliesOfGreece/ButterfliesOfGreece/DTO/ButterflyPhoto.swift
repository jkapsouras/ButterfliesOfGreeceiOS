//
//  ButterflyPhoto.swift
//  ButterfliesOfGreece
//
//  Created by Ioannis Kapsouras on 1/8/20.
//  Copyright © 2020 Ioannis Kapsouras. All rights reserved.
//

import Foundation

enum Genre: String, Codable{
	case M = "M"
	case F = "F"
}

class ButterflyPhoto:NSObject, NSCoding, Codable{
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
		coder.encode (genre.rawValue, forKey: "genre")
		coder.encode (identified, forKey: "iden")
	}
	
	required init?(coder: NSCoder) {
		id = coder.decodeInteger(forKey: "id")
        source = coder.decodeObject (forKey: "src") as! String
        title = coder.decodeObject (forKey: "title") as! String
		author = coder.decodeObject (forKey: "author") as! String
		genre = Genre(rawValue: coder.decodeObject(forKey: "genre") as! String)!
		identified = coder.decodeBool(forKey: "iden")
	}
	
	init(id:Int, source:String, title:String, author:String, genre:Genre, identified:Bool) {
		self.id = id
		self.source = source
		self.title = title
		self.author = author
		self.genre = genre
		self.identified = identified
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

