//
//  HeaderPrintToPdfView.swift
//  ButterfliesOfGreece
//
//  Created by Ioannis Kapsouras on 13/9/20.
//  Copyright © 2020 Ioannis Kapsouras. All rights reserved.
//

import UIKit
import RxSwift

class HeaderPrintToPdfView: UIView {
	@IBOutlet weak var LabelItemsPerPage: UILabel!
	@IBOutlet weak var ButtonArrange: UIButton!
	@IBOutlet weak var ButtonPrint: UIButton!
	@IBOutlet weak var PrintDelete: UIButton!
	@IBOutlet weak var LabelTitle: UILabel!
	
    var contentView:UIView?
	let nibName = "HeaderPrintToPdfView"
//	var UiEvents: Observable<UiEvent>{get
//	{
//		return ViewEvents();
//		}
//	}
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		commonInit()
		prepareViews()
//		prepareTexts()
//		prepareFonts()
//		updateViews()
	}
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		//		commonInit()
	}
	
	func commonInit() {
		contentView = loadViewFromNib()
		contentView?.frame = self.bounds
		contentView?.autoresizingMask = UIView.AutoresizingMask(rawValue: UIView.AutoresizingMask.flexibleWidth.rawValue | UIView.AutoresizingMask.flexibleHeight.rawValue)
		
		// Adding custom subview on top of our view (over any custom drawing > see note below)
		self.addSubview(contentView!)
		
	}
	
	func loadViewFromNib() -> UIView? {
		let nib = UINib(nibName: nibName, bundle: nil)
		return nib.instantiate(withOwner: self, options: nil).first as? UIView
	}
	
	func prepareViews(){
		contentView?.backgroundColor = Constants.Colors.field(darkMode: true).color
		backgroundColor = Constants.Colors.field(darkMode: true).color
		LabelItemsPerPage.textColor = Constants.Colors.field(darkMode: false).color
		LabelTitle.textColor = Constants.Colors.field(darkMode: false).color
	}
	
	func prepareTexts(){
		
	}
	
	func prepareFonts(){
		LabelItemsPerPage.setFont(size: Constants.Fonts.fontPhotosSize)
		LabelTitle.setFont(size: Constants.Fonts.fontPhotosSize)
	}
}
