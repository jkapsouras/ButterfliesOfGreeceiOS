//
//  RecognitionViewEvents.swift
//  ButterfliesOfGreece
//
//  Created by Apprecot on 25/9/20.
//  Copyright © 2020 Ioannis Kapsouras. All rights reserved.
//

import Foundation
import UIKit

enum RecognitionEvents : UiEvent {
	case onlineClicked
	case offlineClicked
	case choosePhotoClicked
	case photoChoosed(image:UIImage)
	case takePhotoClicked
	case photoTaken(image:UIImage)
	case liveRecognitionClicked
	case closeClicked
	case closeLiveClicked
	case liveImageTaken(image:UIImage)
}
