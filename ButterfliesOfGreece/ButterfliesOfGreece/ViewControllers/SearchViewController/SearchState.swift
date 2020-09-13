//
//  SearchState.swift
//  ButterfliesOfGreece
//
//  Created by Ioannis Kapsouras on 5/9/20.
//  Copyright © 2020 Ioannis Kapsouras. All rights reserved.
//

import Foundation

struct SearchState{
	let term:String
	let result:[Specie]
	
	init(term:String, result:[Specie]){
		self.term = term
		self.result = result
	}
}

extension SearchState{
	func with(term:String?, result:[Specie]?) -> SearchState{
		return SearchState(term: term ?? self.term, result: result ?? self.result)
	}
}
