//
//  PhotosEvents.swift
//  ButterfliesOfGreece
//
//  Created by Ioannis Kapsouras on 23/8/20.
//  Copyright © 2020 Ioannis Kapsouras. All rights reserved.
//

import Foundation

enum PhotosEvents:UiEvent{
	case loadPhotos(specieId:Int)
	case photoClicked(id:Int)
	case addPhotoForPrintClicked(photoId:Int)
}
