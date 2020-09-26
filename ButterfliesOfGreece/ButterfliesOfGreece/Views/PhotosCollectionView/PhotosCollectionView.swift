//
//  PhotosCollectionView.swift
//  ButterfliesOfGreece
//
//  Created by Ioannis Kapsouras on 11/8/20.
//  Copyright © 2020 Ioannis Kapsouras. All rights reserved.
//

import UIKit
import RxSwift

class PhotosCollectionView: UIView {
	@IBOutlet weak var CollectionPhotos: UICollectionView!
	
	var contentView:UIView?
	let nibName = "PhotosCollectionView"
	var UiEvents: Observable<UiEvent>{get
	{
		return ViewEvents();
		}
	}
	
	let source = PhotosCollectionSource()
	
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
	
	override func layoutSubviews() {
		updateViews()
	}
	
	func loadViewFromNib() -> UIView? {
		let nib = UINib(nibName: nibName, bundle: nil)
		return nib.instantiate(withOwner: self, options: nil).first as? UIView
	}
	
	func PrepareViews()
	{
		CollectionPhotos.register(PhotosCollectionViewCell.Nib, forCellWithReuseIdentifier: PhotosCollectionViewCell.Key)
		
		self.backgroundColor = Constants.Colors.appWhite.color
		contentView?.backgroundColor = Constants.Colors.appWhite.color
		CollectionPhotos.backgroundColor = Constants.Colors.appWhite.color
	}
	
	func updateViews()
	{
		let layout = CollectionPhotos.collectionViewLayout as! UICollectionViewFlowLayout
		let dimenWidth = (UIScreen.main.bounds.width/2 - 24)
		layout.itemSize = CGSize(width: dimenWidth, height: dimenWidth + 80)
		CollectionPhotos.reloadData()
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
		return source.emitterObs
	}
	
	func ShowFamilies(families: [Family]){
		source.setFamilies(families: families)
		source.setShowingStep(showingStep: .families)
		CollectionPhotos.dataSource = source
		CollectionPhotos.delegate = source
		CollectionPhotos.reloadData()
	}
	
	func ShowSpecies(species: [Specie]){
		source.setSpecies(species: species)
		source.setShowingStep(showingStep: .species)
		CollectionPhotos.dataSource = source
		CollectionPhotos.delegate = source
		CollectionPhotos.reloadData()
	}
	
	func ShowPhotos(photos: [ButterflyPhoto]){
		source.setPhotos(photos: photos)
		source.setShowingStep(showingStep: .photos)
		CollectionPhotos.dataSource = source
		CollectionPhotos.delegate = source
		CollectionPhotos.reloadData()
	}
}
