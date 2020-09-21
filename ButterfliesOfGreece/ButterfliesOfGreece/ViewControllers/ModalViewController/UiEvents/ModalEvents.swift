//
//  ModalEvents.swift
//  ButterfliesOfGreece
//
//  Created by Ioannis Kapsouras on 26/8/20.
//  Copyright © 2020 Ioannis Kapsouras. All rights reserved.
//

import Foundation

enum ModalEvents:UiEvent{
	case loadPhotos(specieId:Int, photoId:Int)
}
