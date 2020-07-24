//
//  ButtonExtensions.swift
//  ButterfliesOfGreece
//
//  Created by Ioannis Kapsouras on 24/7/20.
//  Copyright © 2020 Ioannis Kapsouras. All rights reserved.
//

import Foundation
import UIKit

extension UIButton{

func centerVerticallyWithPadding(padding : CGFloat) {
	guard
		let imageViewSize = self.imageView?.frame.size,
		let titleLabelSize = self.titleLabel?.frame.size else {
		return
	}

	let totalHeight = imageViewSize.height + titleLabelSize.height + padding

	self.imageEdgeInsets = UIEdgeInsets(
		top: max(0, -(totalHeight - imageViewSize.height)),
		left: 0.0,
		bottom: 0.0,
		right: -titleLabelSize.width
	)

	self.titleEdgeInsets = UIEdgeInsets(
		top: (totalHeight - imageViewSize.height),
		left: -imageViewSize.width,
		bottom: -(totalHeight - titleLabelSize.height),
		right: 0.0
	)

	self.contentEdgeInsets = UIEdgeInsets(
		top: 0.0,
		left: 0.0,
		bottom: titleLabelSize.height,
		right: 0.0
	)
}
}
