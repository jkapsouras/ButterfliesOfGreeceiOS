//
//  HeaderView.swift
//  ButterfliesOfGreece
//
//  Created by Ioannis Kapsouras on 11/8/20.
//  Copyright © 2020 Ioannis Kapsouras. All rights reserved.
//

import UIKit
import RxSwift

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
			PrepareViews();
			PrepareTexts();
			PrepareFonts();
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
		
		func PrepareViews()
		{
			self.backgroundColor = Constants.Colors.field(darkMode: false).color
			ButtonChangeViewStyle.setImage(UIImage(named: "listIcon", in: nil, compatibleWith: nil)!.withRenderingMode(.alwaysTemplate), for: .normal)
			ButtonChangeViewStyle.setTitle("", for: .normal)
			ButtonChangeViewStyle.tintColor = Constants.Colors.field(darkMode: true).color
			ButtonChangeViewStyle.imageView?.contentMode = .scaleAspectFit
			ButtonSearch.setImage(UIImage(named: "recognitionIcon", in: nil, compatibleWith: nil)!.withRenderingMode(.alwaysTemplate), for: .normal)
			ButtonSearch.setTitle("", for: .normal)
			ButtonSearch.tintColor = Constants.Colors.field(darkMode: true).color
			ButtonSearch.imageView?.contentMode = .scaleAspectFit
			ButtonAddPhotos.setImage(UIImage(named: "folderIcon", in: nil, compatibleWith: nil)!.withRenderingMode(.alwaysTemplate), for: .normal)
			ButtonAddPhotos.setTitle("", for: .normal)
			ButtonAddPhotos.tintColor = Constants.Colors.field(darkMode: true).color
			ButtonAddPhotos.imageView?.contentMode = .scaleAspectFit
			ViewNumberOfFiles.backgroundColor = Constants.Colors.field(darkMode: false).color
			LabelNumberOfFiles.textColor = Constants.Colors.field(darkMode: true).color
			LabelNumberOfFiles.text = "0"
			LabelNumberOfFiles.setFont(size: Constants.Fonts.addedPhotosSize)
			LableTitle.setFont(size: Constants.Fonts.fontPhotosSize)
			ViewNumberOfFiles.layer.borderColor = Constants.Colors.field(darkMode: true).color.cgColor
			ViewNumberOfFiles.layer.borderWidth = 1
			ViewNumberOfFiles.layer.cornerRadius = ViewNumberOfFiles.bounds.height/2
		}
		
		func UpdateViews()
		{
			
		}
		
		func PrepareTexts()
		{
		}
		
		func PrepareFonts()
		{
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
			return Observable.never()
		}
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
