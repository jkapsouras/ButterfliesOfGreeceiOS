//
//  StringsExtensions.swift
//  ButterfliesOfGreece
//
//  Created by Ioannis Kapsouras on 5/7/20.
//  Copyright © 2020 Ioannis Kapsouras. All rights reserved.
//

import Foundation
import UIKit
extension String{
	
	func Localise()->String{
		return Bundle.main.localizedString(forKey: self, value: self, table: nil)
	}
	
	/**This method gets size of a string with a particular font.
	*/
	func size(usingFont font: UIFont) -> CGSize {
		let attributedString = NSAttributedString(string: self, attributes: [NSAttributedString.Key.font : font])
		return attributedString.size()
	}
	
}

extension NSMutableAttributedString {
	public func setAsLink(textToFind:String, linkURL:String, appFont:String, fontSize: CGFloat, color:UIColor) -> Bool {
		
		let foundRange = self.mutableString.range(of: textToFind)
		if foundRange.location != NSNotFound {
			
			self.addAttribute(.link, value: linkURL, range: foundRange)
			self.addAttribute(.font, value: UIFont.init(name: appFont, size: fontSize)!, range: NSRange(location: 0, length: self.length))
			self.addAttribute(.foregroundColor, value: color, range: NSRange(location: 0, length: self.length))
			
			
			return true
		}
		return false
	}
	
	public func setAsBold(textToFind:String) -> Bool {
		
		let foundRange = self.mutableString.range(of: textToFind)
		if foundRange.location != NSNotFound {
			
			self.addAttribute(.font, value: UIFont.init(name: Constants.Fonts.appFont, size: Constants.Fonts.titleControllerSise)!, range: foundRange)
			
			return true
		}
		return false
	}
	
}
