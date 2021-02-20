//
//  RecognitionState.swift
//  ButterfliesOfGreece
//
//  Created by Apprecot on 25/9/20.
//  Copyright © 2020 Ioannis Kapsouras. All rights reserved.
//

import Foundation
import UIKit

struct RecognitionState {
	let imageData:Data?
	let image:UIImage?
	let imagePixelBuffer:CVPixelBuffer?
	let predictions:[Prediction]
	
	init(image:UIImage?, imageData:Data?, imagePixelBuffer:CVPixelBuffer?, predictions:[Prediction]){
		self.image = image
		self.imageData = imageData
		self.predictions = predictions
		self.imagePixelBuffer = imagePixelBuffer
	}
}

extension RecognitionState{
	func with(image:UIImage? = nil, imageData:Data? = nil, imagePixelBuffer: CVPixelBuffer? = nil, predictions:[Prediction]? = nil) -> RecognitionState{
		return RecognitionState(image: image ?? self.image, imageData: imageData ?? self.imageData, imagePixelBuffer: imagePixelBuffer ?? self.imagePixelBuffer, predictions: predictions ?? self.predictions)
	}
}
