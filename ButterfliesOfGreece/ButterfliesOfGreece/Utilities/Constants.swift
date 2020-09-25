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
		case appWhite
	}
	
	struct Fonts
	{
		static let notchTop = 44
		static let appFont = "Aka-Acid-TypoGrotesk"
		static let fontHeaderSize:CGFloat = 12
		static let fontMenuSize:CGFloat = 14
		static let fontPhotosSize:CGFloat = 16
		static let titleControllerSise:CGFloat = 18
		static let addedPhotosSize:CGFloat = 8
	}
	
	static let TermsPdf = "127557_2178_2015"
	static let FormsPdf = "135366-16"
	static let SpeciesPdf = "species"
	
	struct Network{
		static let BaseAddress:String = "http://butterfliesofgreece-env.eba-w5n3apy5.us-east-1.elasticbeanstalk.com";
		
		enum HttpHeaderField: String {
			case authentication = "Authorization"
			case contentType = "Content-Type"
			case acceptType = "Accept"
			case acceptEncoding = "Accept-Encoding"
		}
		
		//The content type (JSON)
		enum ContentType: String {
			case json = "application/json"
			case multiPart = "multipart/form-data"
		}
	}
}

extension Constants.Colors {
	var color: UIColor {
		get {
			switch self {
			case .field(let darkMode):
				return (darkMode ? UIColor(hex: "#5e6ea2") : UIColor(hex: "#e3e7f2"))
			case .introduction(let darkMode):
				return (darkMode ?  UIColor(hex: "#6fa4b2") : UIColor(hex: "#EBF4F6"))
			case .legal(let darkMode):
				return (darkMode ?  UIColor(hex: "#c67d6a") : UIColor(hex: "#FAF2EE"))
			case .about(let darkMode):
				return (darkMode ?  UIColor(hex: "#afab14") : UIColor(hex: "#F8F9EB"))
			case .contribute(let darkMode):
				return (darkMode ?  UIColor(hex: "#75619e") : UIColor(hex: "#E8E6F1"))
			case .endangered(let darkMode):
				return (darkMode ?  UIColor(hex: "#b16b73") : UIColor(hex: "#F5EAE7"))
			case .recognition(let darkMode):
				return (darkMode ?  UIColor(hex: "#6b9972") : UIColor(hex: "#E8EEE8"))
			case .appWhite:
				return UIColor.white
			}
		}
	}
}
