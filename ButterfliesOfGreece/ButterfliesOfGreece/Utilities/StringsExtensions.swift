//
//  StringsExtensions.swift
//  ButterfliesOfGreece
//
//  Created by Ioannis Kapsouras on 5/7/20.
//  Copyright © 2020 Ioannis Kapsouras. All rights reserved.
//

import Foundation

extension String{
	
	func Localise()->String{
		return Translations.AppBundle.localizedString(forKey: self, value: self, table: nil)
	}
	
}
