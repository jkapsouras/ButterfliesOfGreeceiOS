//
//  Predictions.swift
//  ButterfliesOfGreece
//
//  Created by Ioannis Kapsouras on 23/9/20.
//  Copyright © 2020 Ioannis Kapsouras. All rights reserved.
//

import Foundation

struct Avatar:Codable{
	var avatar:Data
}

struct Predictions:Codable{
	var predictions:[Prediction]
	
	init(){
		predictions = [Prediction]()
	}
	
	init(predictions:[Prediction]){
		self.predictions = predictions
	}
}

struct Prediction:Codable{
	var butterflyClass:String
	var output:Double
	var prob:Double
	
	enum CodingKeys: String, CodingKey {
		case butterflyClass = "class"
		case output
		case prob
		
	}
	
	init(butterflyClass: String, output: Double, prob: Double) {
		self.butterflyClass = butterflyClass
		self.output = output
		self.prob = prob
	}
	
	init(){
		self.butterflyClass = ""
		self.output = 0
		self.prob = 0
	}
}
