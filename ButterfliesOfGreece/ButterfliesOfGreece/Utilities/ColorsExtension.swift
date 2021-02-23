//
//  ColorsExtension.swift
//  ButterfliesOfGreece
//
//  Created by Ioannis Kapsouras on 31/7/20.
//  Copyright © 2020 Ioannis Kapsouras. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    convenience init(hex: String, alpha: CGFloat = 1.0) {
		var hexFormatted: String = hex.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).uppercased()

		if hexFormatted.hasPrefix("#") {
			hexFormatted = String(hexFormatted.dropFirst())
		}

		assert(hexFormatted.count == 6, "Invalid hex code used.")

		var rgbValue: UInt64 = 0
		Scanner(string: hexFormatted).scanHexInt64(&rgbValue)

		self.init(red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
				  green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
				  blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
				  alpha: alpha)
	}
	
	func getModified(byPercentage percent: CGFloat) -> UIColor? {
		
		var red: CGFloat = 0.0
		var green: CGFloat = 0.0
		var blue: CGFloat = 0.0
		var alpha: CGFloat = 0.0
		
		guard self.getRed(&red, green: &green, blue: &blue, alpha: &alpha) else {
			return nil
		}
		
		// Returns the color comprised by percentage r g b values of the original color.
		let colorToReturn = UIColor(displayP3Red: min(red + percent / 100.0, 1.0), green: min(green + percent / 100.0, 1.0), blue: min(blue + percent / 100.0, 1.0), alpha: 1.0)
		
		return colorToReturn
	}
}
