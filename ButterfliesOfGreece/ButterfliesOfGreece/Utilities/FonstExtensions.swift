//
//  FonstExtensions.swift
//  ButterfliesOfGreece
//
//  Created by Ioannis Kapsouras on 9/8/20.
//  Copyright © 2020 Ioannis Kapsouras. All rights reserved.
//

import Foundation
import UIKit

struct Fonts {
	func printFonts(){
		for family in UIFont.familyNames.sorted() {
			let names = UIFont.fontNames(forFamilyName: family)
			print("Family: \(family) Font names: \(names)")
		}
	}
}

extension UIButton{
	func setFont(size: CGFloat)
	{
		guard self.titleLabel != nil else {
			return
		}
		self.titleLabel!.font = UIFont(name: Constants.Fonts.appFont, size: size) ?? UIFont.systemFont(ofSize: Constants.Fonts.fontMenuSize)
	}
}

extension UILabel{
	func setFont(size: CGFloat)
	{
		self.font = UIFont(name: Constants.Fonts.appFont, size: size) ?? UIFont.systemFont(ofSize: Constants.Fonts.fontMenuSize)
	}
}
