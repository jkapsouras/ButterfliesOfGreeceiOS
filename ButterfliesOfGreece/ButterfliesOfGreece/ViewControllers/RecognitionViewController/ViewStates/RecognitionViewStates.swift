//
//  RecognitionViewStates.swift
//  ButterfliesOfGreece
//
//  Created by Apprecot on 25/9/20.
//  Copyright © 2020 Ioannis Kapsouras. All rights reserved.
//

import Foundation
import UIKit

enum RecognitionViewStates : ViewState{
	case showGallery
	case showCamera
	case imageRecognized(predictions:[Prediction])
	case liveImageRecognized(predictions:[Prediction])
	case showRecognitionView(image:UIImage)
	case recognitionStarted
	case closeRecognitionView
	case showLiveRecognitionView
	case closeLiveRecognitionView
	
	var isTransition: Bool{
		return false
	}
}
