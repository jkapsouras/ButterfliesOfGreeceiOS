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
		case field(darkMode:Bool)
		case introduction(darkMode:Bool)
		case legal(darkMode:Bool)
		case about(darkMode:Bool)
		case contribute(darkMode:Bool)
		case endangered(darkMode:Bool)
		case recognition(darkMode:Bool)
	}
	
	struct Fonts
	{
		static let notchTop = 44
		static let appFont = "Aka-Acid-TypoGrotesk"
		static let fontMenuSize:CGFloat = 14
	}
	
}
extension Constants.Colors {
	var color: UIColor {
		get {
			switch self {
			case .field(let darkMode):
				return (darkMode ? UIColor(hex: "#6c80bf") : UIColor(hex: "#e3e7f2"))
			case .introduction(let darkMode):
				return (darkMode ?  UIColor(hex: "#91C6D5") : UIColor(hex: "#EBF4F6"))
			case .legal(let darkMode):
				return (darkMode ?  UIColor(hex: "#EDB299") : UIColor(hex: "#FAF2EE"))
			case .about(let darkMode):
				return (darkMode ?  UIColor(hex: "#DFE48C") : UIColor(hex: "#F8F9EB"))
			case .contribute(let darkMode):
				return (darkMode ?  UIColor(hex: "#7E66A6") : UIColor(hex: "#E8E6F1"))
			case .endangered(let darkMode):
				return (darkMode ?  UIColor(hex: "#C4787D") : UIColor(hex: "#F5EAE7"))
			case .recognition(let darkMode):
				return (darkMode ?  UIColor(hex: "#7DB283") : UIColor(hex: "#E8EEE8")) 
			}
		}
	}
}
