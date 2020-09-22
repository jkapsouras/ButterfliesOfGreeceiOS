//
//  HeaderView.swift
//  ButterfliesOfGreece
//
//  Created by Ioannis Kapsouras on 11/8/20.
//  Copyright © 2020 Ioannis Kapsouras. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class HeaderView: UIView {
	@IBOutlet weak var LableTitle: UILabel!
	@IBOutlet weak var ButtonAddPhotos: UIButton!
	@IBOutlet weak var ButtonChangeViewStyle: UIButton!
	@IBOutlet weak var ButtonSearch: UIButton!
	@IBOutlet weak var ViewNumberOfFiles: UIView!
	@IBOutlet weak var LabelNumberOfFiles: UILabel!
	@IBOutlet weak var ConstViewNumberTrailing: NSLayoutConstraint!
	
	var contentView:UIView?
	let nibName = "HeaderView"
	var UiEvents: Observable<UiEvent>{get
	{
		return ViewEvents();
		}
	}
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		commonInit()
		prepareViews()
		prepareTexts()
		prepareFonts()
		updateViews()
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
	
	func prepareViews()
	{
		self.backgroundColor = Constants.Colors.field(darkMode: true).color
		contentView?.backgroundColor = Constants.Colors.field(darkMode: true).color
		ButtonChangeViewStyle.setImage(UIImage(named: "listIcon", in: nil, compatibleWith: nil)!.withRenderingMode(.alwaysTemplate), for: .normal)
		ButtonChangeViewStyle.tintColor = Constants.Colors.field(darkMode: false).color
		ButtonChangeViewStyle.imageView?.contentMode = .scaleAspectFit
		ButtonSearch.setImage(UIImage(named: "recognitionIcon", in: nil, compatibleWith: nil)!.withRenderingMode(.alwaysTemplate), for: .normal)
		ButtonSearch.tintColor = Constants.Colors.field(darkMode: false).color
		ButtonSearch.imageView?.contentMode = .scaleAspectFit
		ButtonAddPhotos.setImage(UIImage(named: "folderIcon", in: nil, compatibleWith: nil)!.withRenderingMode(.alwaysTemplate), for: .normal)
		ButtonAddPhotos.tintColor = Constants.Colors.field(darkMode: false).color
		ButtonAddPhotos.imageView?.contentMode = .scaleAspectFit
		ViewNumberOfFiles.backgroundColor = Constants.Colors.field(darkMode: true).color
		LabelNumberOfFiles.textColor = Constants.Colors.field(darkMode: false).color
		ViewNumberOfFiles.layer.borderColor = Constants.Colors.field(darkMode: false).color.cgColor
		ViewNumberOfFiles.layer.borderWidth = 1
		LableTitle.textColor = Constants.Colors.field(darkMode: false).color
		
	}
	
	func updateViews()
	{
		ViewNumberOfFiles.layer.cornerRadius = ViewNumberOfFiles.bounds.height/2
	}
	
	func prepareTexts()
	{
		ButtonChangeViewStyle.setTitle("", for: .normal)
		ButtonSearch.setTitle("", for: .normal)
		ButtonAddPhotos.setTitle("", for: .normal)
		LabelNumberOfFiles.text = "0"
		LableTitle.text = Translations.Families
	}
	
	func prepareFonts()
	{
		LableTitle.setFont(size: Constants.Fonts.fontPhotosSize)
		LabelNumberOfFiles.setFont(size: Constants.Fonts.addedPhotosSize)
	}
	
	func subscribe(){
		
	}
	
	func Show()
	{
		if (alpha == 0)
		{
			alpha = 1
			//	this.FadeIn();
			//	_contentView.FadeIn();
		}
	}
	
	func Hide()
	{
		if (alpha == 1)
		{
			alpha=0
			//	this.FadeOut();
			//	_contentView.FadeOut();
		}
	}
	
	func ViewEvents() -> Observable<UiEvent>
	{
		return Observable.merge(ButtonChangeViewStyle.rx.tap.map{_ in HeaderViewEvents.switchViewStyleClicked},
		ButtonSearch.rx.tap.map{_ in HeaderViewEvents.searchBarClicked},
		ButtonAddPhotos.rx.tap.map{_ in HeaderViewEvents.printPhotosClicked})
	}
	
	func changeViewForViewArrange(viewArrange: ViewArrange){
		switch viewArrange {
		case .grid:
			ButtonChangeViewStyle.setImage(UIImage(named: "listIcon", in: nil, compatibleWith: nil)!.withRenderingMode(.alwaysTemplate), for: .normal)
		case .list:
			ButtonChangeViewStyle.setImage(UIImage(named: "gridIcon", in: nil, compatibleWith: nil)!.withRenderingMode(.alwaysTemplate), for: .normal)
		}
	}
	
	func updateNumberOfPhotos(number:Int){
		LabelNumberOfFiles.text = String(number)
	}
	
	func updateTitle(title:String){
		LableTitle.text = title
	}
}
