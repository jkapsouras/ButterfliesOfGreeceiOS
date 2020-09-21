//
//  LegalViewStates.swift
//  ButterfliesOfGreece
//
//  Created by Ioannis Kapsouras on 20/9/20.
//  Copyright © 2020 Ioannis Kapsouras. All rights reserved.
//

import Foundation

enum LegalViewStates:ViewState{
	case showTermsPdf(document: String)
	case showFormsPdf(document: String)
	case showPopup
	case hidePopup
	
	var isTransition: Bool{
		return false
	}
}
