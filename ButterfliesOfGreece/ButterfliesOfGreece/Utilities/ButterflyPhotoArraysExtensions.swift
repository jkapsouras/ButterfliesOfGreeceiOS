//
//  ArraysExtensions.swift
//  ButterfliesOfGreece
//
//  Created by Ioannis Kapsouras on 17/8/20.
//  Copyright © 2020 Ioannis Kapsouras. All rights reserved.
//

import Foundation

extension Array where Element: ButterflyPhoto{
	var uniques: Array{
		
		let tmp = self.sorted{$0.source < $1.source}
		let studentsByLetter = Dictionary(grouping: tmp, by: { $0.source })
		let ph = studentsByLetter.compactMap{obj in obj.value.first}
		return ph
	}
}
