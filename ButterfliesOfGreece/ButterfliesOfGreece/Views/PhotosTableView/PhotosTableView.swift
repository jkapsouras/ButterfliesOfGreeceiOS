//
//  PhotosTableView.swift
//  ButterfliesOfGreece
//
//  Created by Ioannis Kapsouras on 11/8/20.
//  Copyright © 2020 Ioannis Kapsouras. All rights reserved.
//

import UIKit
import RxSwift

@IBDesignable
class PhotosTableView: UIView {
	@IBOutlet weak var TablePhotos: UITableView!
	
    var contentView:UIView?
		let nibName = "PhotosTableView"
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
			self.backgroundColor = UIColor.clear
			contentView?.backgroundColor = UIColor.white
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
			if (contentView?.alpha == 0)
			{
				alpha = 1
				contentView?.alpha = 1
				//	this.FadeIn();
				//	_contentView.FadeIn();
			}
		}
		
		func Hide()
		{
			if (contentView?.alpha == 1)
			{
				contentView?.alpha=0
				//	this.FadeOut();
				//	_contentView.FadeOut();
			}
			self.alpha = 0
			contentView?.alpha = 0
		}
		
		func ViewEvents() -> Observable<UiEvent>
		{
			return Observable.never()
		}
}
