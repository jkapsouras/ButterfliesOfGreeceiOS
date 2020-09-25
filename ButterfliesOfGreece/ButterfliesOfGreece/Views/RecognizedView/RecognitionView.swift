//
//  RecognitionView.swift
//  ButterfliesOfGreece
//
//  Created by Apprecot on 25/9/20.
//  Copyright © 2020 Ioannis Kapsouras. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class RecognitionView: UIView {
	@IBOutlet weak var LabelRecognized: UILabel!
	@IBOutlet weak var ImageChosen: UIImageView!
	@IBOutlet weak var ViewButtons: UIView!
	@IBOutlet weak var ViewInner: UIView!
	@IBOutlet weak var ButtonOnline: UIButton!
	@IBOutlet weak var ButtonOffline: UIButton!
	@IBOutlet weak var SpinnerLoading: UIActivityIndicatorView!
	@IBOutlet weak var ConstLabelTop: NSLayoutConstraint!
	@IBOutlet weak var ConstLabelBottom: NSLayoutConstraint!
	
	var contentView:UIView?
	let nibName = "RecognitionView"
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
	
	func prepareViews(){
		contentView?.backgroundColor = Constants.Colors.recognition(darkMode: false).color
		backgroundColor = Constants.Colors.recognition(darkMode: false).color
		LabelRecognized.textColor = Constants.Colors.recognition(darkMode: true).color
		ImageChosen.contentMode = .scaleToFill
		ViewButtons.backgroundColor = Constants.Colors.appWhite.color.withAlphaComponent(0.5)
		ButtonOnline.setTitleColor(Constants.Colors.recognition(darkMode: true).color, for: .normal)
		ButtonOnline.backgroundColor = Constants.Colors.recognition(darkMode: false).color
		ButtonOnline.layer.borderColor = Constants.Colors.recognition(darkMode: true).color.cgColor
		ButtonOnline.layer.borderWidth = 2
		ButtonOffline.setTitleColor(Constants.Colors.recognition(darkMode: true).color, for: .normal)
		ButtonOffline.backgroundColor = Constants.Colors.recognition(darkMode: false).color
		ButtonOffline.layer.borderColor = Constants.Colors.recognition(darkMode: true).color.cgColor
		ButtonOffline.layer.borderWidth = 2
		SpinnerLoading.color = Constants.Colors.recognition(darkMode: true).color
		ConstLabelTop.constant = 0
		ConstLabelBottom.constant = 0
	}
	
	func updateViews(){
		ButtonOnline.layer.cornerRadius = ButtonOnline.frame.height/2
		ButtonOffline.layer.cornerRadius = ButtonOffline.frame.height/2
	}
	
	func prepareTexts(){
		LabelRecognized.text = ""
		ButtonOnline.setTitle(Translations.RecognizeOnline, for: .normal)
		ButtonOffline.setTitle(Translations.RecognizeOffline, for: .normal)
	}
	
	func prepareFonts(){
		LabelRecognized.setFont(size: Constants.Fonts.fontMenuSize)
		ButtonOnline.setFont(size: Constants.Fonts.fontMenuSize)
		ButtonOffline.setFont(size: Constants.Fonts.fontMenuSize)
	}
	
	func showSelectedImage(image:UIImage){
		ImageChosen.image = image
	}
	
	func imageRecognized(predictions:[Prediction]){
		ViewButtons.alpha=0
		LabelRecognized.text = predictions[0].butterflyClass
		ConstLabelTop.constant = 8
		ConstLabelBottom.constant = 16
	}
	
	func showLoading(){
		SpinnerLoading.alpha = 1
		SpinnerLoading.startAnimating()
		ButtonOnline.alpha = 0
		ButtonOffline.alpha = 0
	}
	
	func hideLoading(){
		SpinnerLoading.alpha = 0
		SpinnerLoading.stopAnimating()
		ButtonOnline.alpha = 1
		ButtonOffline.alpha = 1
	}
	
	func ViewEvents() -> Observable<UiEvent>
	{
		return Observable.merge(ButtonOnline.rx.tap.map{_ in RecognitionEvents.onlineClicked},
								ButtonOffline.rx.tap.map{_ in RecognitionEvents.offlineClicked})
	}
}
