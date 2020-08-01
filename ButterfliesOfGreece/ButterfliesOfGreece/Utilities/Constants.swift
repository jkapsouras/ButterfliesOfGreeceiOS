//
//  Constants.swift
//  ButterfliesOfGreece
//
//  Created by Ioannis Kapsouras on 31/7/20.
//  Copyright © 2020 Ioannis Kapsouras. All rights reserved.
//

import Foundation
import UIKit

struct Constants {
	
	enum Colors {
		case field
		case introduction
		case legal
		case about
		case contribute
		case endangered
		case recognition
	}
	
}
extension Constants.Colors {
	var color: UIColor {
		get {
			switch self {
			case .field:
				return UIColor(hex: "#1f5faaff") ?? UIColor.white
			case .introduction:
				return UIColor(hex: "#3F220Fff") ?? UIColor.green
			case .legal:
				return UIColor(hex: "#E4572EFF") ?? UIColor.red
			case .about:
				return UIColor(hex: "#607466FF") ?? UIColor.gray
			case .contribute:
				return UIColor(hex: "#320E3BFF") ?? UIColor.blue
			case .endangered:
				return UIColor(hex: "#8EA604FF") ?? UIColor.yellow
			case .recognition:
				return UIColor(hex: "#48A9A6FF") ?? UIColor.brown
			}
		}
	}
}
