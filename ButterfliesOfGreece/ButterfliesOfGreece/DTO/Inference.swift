//
//  Result.swift
//  ButterfliesOfGreece
//
//  Created by Apprecot on 29/9/20.
//  Copyright © 2020 Ioannis Kapsouras. All rights reserved.
//

import Foundation

/// An inference from invoking the `Interpreter`.
struct Inference {
	let confidence: Float
	let label: String
}

extension Inference{
	
	func to() -> Prediction{
		return Prediction(butterflyClass: self.label, output: -1, prob: Double(self.confidence))
	}
	
}
