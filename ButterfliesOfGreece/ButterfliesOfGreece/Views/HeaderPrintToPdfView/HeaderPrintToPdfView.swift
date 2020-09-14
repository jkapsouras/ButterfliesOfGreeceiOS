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
	@IBOutlet weak var LabelTitle: UILabel!
	@IBOutlet weak var ButtonDelete: UIButton!
	
	var contentView:UIView?
	let nibName = "HeaderPrintToPdfView"
		var UiEvents: Observable<UiEvent>{get
		{
			return ViewEvents();
			}
		}
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		commonInit()
		prepareTexts()
		prepareFonts()
		prepareViews()
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
		
		ButtonArrange.setTitle("1", for: .normal)
		ButtonArrange.setImage(UIImage(named: "expandIcon"), for: .normal)
		ButtonArrange.contentMode = .scaleAspectFit
		ButtonArrange.imageView?.contentMode = .scaleAspectFit
		ButtonArrange.titleEdgeInsets = UIEdgeInsets(top: 0, left: -ButtonArrange.imageView!.frame.size.width, bottom: 0, right: ButtonArrange.imageView!.frame.size.width);
		ButtonArrange.imageEdgeInsets = UIEdgeInsets(top: 8, left: ButtonArrange.titleLabel!.frame.size.width, bottom: 10, right: -ButtonArrange.titleLabel!.frame.size.width);
		ButtonArrange.setTitleColor(Constants.Colors.field(darkMode: false).color, for: .normal)
		ButtonArrange.tintColor = Constants.Colors.field(darkMode: false).color
		ButtonDelete.setImage(UIImage(named: "deleteIcon"), for: .normal)
		ButtonDelete.contentMode = .scaleAspectFit
		ButtonDelete.imageView?.contentMode = .scaleAspectFit
		ButtonDelete.tintColor = Constants.Colors.field(darkMode: false).color
		ButtonDelete.setTitle("", for: .normal)
		ButtonDelete.imageEdgeInsets = UIEdgeInsets(top: 12, left: 8, bottom: 14, right: 8);
		ButtonPrint.setImage(UIImage(named: "printIcon"), for: .normal)
		ButtonPrint.contentMode = .scaleAspectFit
		ButtonPrint.imageView?.contentMode = .scaleAspectFit
		ButtonPrint.tintColor = Constants.Colors.field(darkMode: false).color
		ButtonPrint.setTitle("", for: .normal)
		ButtonPrint.imageEdgeInsets = UIEdgeInsets(top: 12, left: 8, bottom: 12, right: 8);
		
	}
	
	func prepareTexts(){
		LabelItemsPerPage.text = "\(Translations.Images)/\(Translations.Page):"
	}
	
	func prepareFonts(){
		LabelItemsPerPage.setFont(size: Constants.Fonts.fontHeaderSize)
		LabelTitle.setFont(size: Constants.Fonts.fontHeaderSize)
		ButtonArrange.setFont(size: Constants.Fonts.fontHeaderSize)
	}
	
	func ViewEvents() -> Observable<UiEvent>
	{
		return Observable.never()
	}
}
