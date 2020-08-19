//
//  Storage.swift
//  ButterfliesOfGreece
//
//  Created by Ioannis Kapsouras on 15/8/20.
//  Copyright © 2020 Ioannis Kapsouras. All rights reserved.
//

import Foundation

struct Storage {
	lazy var families:[Family] = {
		return self.ReadData(fileName: "data", type: "json")
	}()
	
	mutating func species(familyId:Int) -> [Specie]{
		return families.filter{$0.id == familyId}.flatMap{$0.species}
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
