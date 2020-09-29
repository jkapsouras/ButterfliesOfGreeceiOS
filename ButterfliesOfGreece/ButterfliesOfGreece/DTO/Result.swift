//
//  Result.swift
//  ButterfliesOfGreece
//
//  Created by Apprecot on 29/9/20.
//  Copyright © 2020 Ioannis Kapsouras. All rights reserved.
//

import Foundation

/// A result from invoking the `Interpreter`.
struct Result {
	let inferenceTime: Double
	let inferences: [Inference]
}

extension Result{
	
	func to() -> Predictions{
		var predictions = [Prediction]()
		for inference in self.inferences{
			let prediction = inference.to()
			predictions.append(prediction)
		}
		return Predictions(predictions: predictions)
	}
	
}
