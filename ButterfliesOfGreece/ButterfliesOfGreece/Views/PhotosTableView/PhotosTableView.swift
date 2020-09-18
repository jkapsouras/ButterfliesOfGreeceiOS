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
	
	let source = PhotosTableSource()
	
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
		TablePhotos.register(PhotosTableViewCell.Nib, forCellReuseIdentifier: PhotosTableViewCell.Key)
		
		self.backgroundColor = UIColor.red
		TablePhotos.backgroundColor = UIColor.green
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
		}
		self.alpha = 0
	}
	
	func ViewEvents() -> Observable<UiEvent>
	{
		return source.emitterObs
	}
	
	func ShowFamilies(families: [Family]){
		source.setFamilies(families: families)
		source.setShowingStep(showingStep: .families)
		TablePhotos.separatorStyle = .none
		TablePhotos.dataSource = source
		TablePhotos.delegate = source
		TablePhotos.reloadData()
	}
	
	func ShowSpecies(species: [Specie], fromSearch: Bool){
		source.setSpecies(species: species)
		source.setShowingStep(showingStep: .species)
		source.setFromSearch(fromSearch: fromSearch)
		TablePhotos.separatorStyle = .none
		TablePhotos.dataSource = source
		TablePhotos.delegate = source
		TablePhotos.reloadData()
	}
	
	func ShowPhotos(photos: [ButterflyPhoto]){
		source.setPhotos(photos: photos)
		source.setShowingStep(showingStep: .photos)
		TablePhotos.separatorStyle = .none
		TablePhotos.dataSource = source
		TablePhotos.delegate = source
		TablePhotos.reloadData()
	}
	
	func ShowPhotosToPrint(photos: [ButterflyPhoto]){
		source.setPhotos(photos: photos)
		source.setShowingStep(showingStep: .photosToPrint)
		TablePhotos.separatorStyle = .none
		TablePhotos.dataSource = source
		TablePhotos.delegate = source
		TablePhotos.reloadData()
	}
}
