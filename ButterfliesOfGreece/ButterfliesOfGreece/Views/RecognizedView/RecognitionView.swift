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
	@IBOutlet weak var ButtonClose: UIButton!
	@IBOutlet weak var ConstButtonHeight: NSLayoutConstraint!
	@IBOutlet weak var ConstButtonBottom: NSLayoutConstraint!
	@IBOutlet weak var ViewOverlay: OverlayView!
	
	private let displayFont = UIFont.systemFont(ofSize: 14.0, weight: .medium)
	private let edgeOffset: CGFloat = 2.0
	
	@IBOutlet weak var ButtonSave: UIButton!
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
		ImageChosen.contentMode = .scaleAspectFill
		ViewButtons.backgroundColor = Constants.Colors.appWhite.color.withAlphaComponent(0.5)
		ButtonOnline.setTitleColor(Constants.Colors.recognition(darkMode: true).color, for: .normal)
		ButtonOnline.backgroundColor = Constants.Colors.recognition(darkMode: false).color
		ButtonOnline.layer.borderColor = Constants.Colors.recognition(darkMode: true).color.cgColor
		ButtonOnline.layer.borderWidth = 2
		ButtonOffline.setTitleColor(Constants.Colors.recognition(darkMode: true).color, for: .normal)
		ButtonOffline.backgroundColor = Constants.Colors.recognition(darkMode: false).color
		ButtonOffline.layer.borderColor = Constants.Colors.recognition(darkMode: true).color.cgColor
		ButtonOffline.layer.borderWidth = 2
		ButtonSave.setTitleColor(Constants.Colors.recognition(darkMode: true).color, for: .normal)
		ButtonSave.backgroundColor = Constants.Colors.recognition(darkMode: false).color
		ButtonSave.layer.borderColor = Constants.Colors.recognition(darkMode: true).color.cgColor
		ButtonSave.layer.borderWidth = 2
		SpinnerLoading.color = Constants.Colors.recognition(darkMode: true).color
		ConstLabelTop.constant = 0
		ConstLabelBottom.constant = 0
		ConstButtonHeight.constant = 0
		ConstButtonBottom.constant = 0
		
		ButtonClose.setImage(UIImage(imageLiteralResourceName: "closeX").withRenderingMode(.alwaysTemplate), for: .normal)
		ButtonClose.tintColor = Constants.Colors.recognition(darkMode: true).color
		
//		ButtonOffline.isUserInteractionEnabled = false
//		ButtonOffline.alpha = 0.5
	}
	
	func updateViews(){
		ButtonOnline.layer.cornerRadius = ButtonOnline.frame.height/2
		ButtonOffline.layer.cornerRadius = ButtonOffline.frame.height/2
		ButtonSave.layer.cornerRadius = ButtonOffline.frame.height/2
	}
	
	func prepareTexts(){
		LabelRecognized.text = ""
		ButtonOnline.setTitle(Translations.RecognizeOnline, for: .normal)
		ButtonOffline.setTitle(Translations.RecognizeOffline, for: .normal)
		ButtonSave.setTitle(Translations.Save, for: .normal)
	}
	
	func prepareFonts(){
		LabelRecognized.setFont(size: Constants.Fonts.titleControllerSise)
		ButtonOnline.setFont(size: Constants.Fonts.titleControllerSise)
		ButtonOffline.setFont(size: Constants.Fonts.titleControllerSise)
		ButtonSave.setFont(size: Constants.Fonts.titleControllerSise)
	}
	
	func showSelectedImage(image:UIImage){
		ImageChosen.image = image
		ViewButtons.alpha = 1
		ConstLabelTop.constant = 0
		ConstLabelBottom.constant = 0
		ConstButtonBottom.constant = 0
		ConstButtonHeight.constant = 0
		LabelRecognized.text = ""
	}
	
	func imageRecognized(predictions:[Prediction]){
		ViewButtons.alpha=0
		LabelRecognized.text = "\(Translations.RecognizedFirst) \(predictions[0].butterflyClass)"//" \(Translations.RecognizedSecond) \(predictions[0].prob)%"
		ConstLabelTop.constant = 16
		ConstLabelBottom.constant = 16
		ConstButtonBottom.constant = 16
		ConstButtonHeight.constant = 40
	}
	
	func showLoading(){
		SpinnerLoading.alpha = 1
		SpinnerLoading.startAnimating()
		ButtonOnline.alpha = 0
		ButtonOffline.alpha = 0
		ButtonSave.alpha = 0
	}
	
	func hideLoading(){
		SpinnerLoading.alpha = 0
		SpinnerLoading.stopAnimating()
		ButtonOnline.alpha = 1
		ButtonOffline.alpha = 1
		ButtonSave.alpha = 1
	}
	
	func ViewEvents() -> Observable<UiEvent>
	{
		return Observable.merge(ButtonOnline.rx.tap.map{_ in RecognitionEvents.onlineClicked},
								ButtonOffline.rx.tap.map{_ in RecognitionEvents.offlineClicked},
								ButtonClose.rx.tap.map{_ in RecognitionEvents.closeClicked},
								ButtonSave.rx.tap.map{_ in RecognitionEvents.saveImage})
	}
	
	func drawAfterPerformingCalculations(onInferences inferences: [DetectionInference], withImageSize imageSize:CGSize) {
		
		ViewOverlay.objectOverlays = []
		ViewOverlay.setNeedsDisplay()
		
		guard !inferences.isEmpty else {
			return
		}
		
		var objectOverlays: [ObjectOverlay] = []
		
		for inference in inferences {
			
			// Translates bounding box rect to current view.
			var convertedRect = inference.rect.applying(CGAffineTransform(scaleX: ViewOverlay.bounds.size.width / imageSize.width, y: ViewOverlay.bounds.size.height / imageSize.height))
			
			if convertedRect.origin.x < 0 {
				convertedRect.origin.x = self.edgeOffset
			}
			
			if convertedRect.origin.y < 0 {
				convertedRect.origin.y = self.edgeOffset
			}
			
			if convertedRect.maxY > ViewOverlay.bounds.maxY {
				convertedRect.size.height = ViewOverlay.bounds.maxY - convertedRect.origin.y - self.edgeOffset
			}
			
			if convertedRect.maxX > ViewOverlay.bounds.maxX {
				convertedRect.size.width = ViewOverlay.bounds.maxX - convertedRect.origin.x - self.edgeOffset
			}
			
			let confidenceValue = Int(inference.confidence * 100.0)
			let string = "\(inference.className)  (\(confidenceValue)%)"
			
			let size = string.size(usingFont: self.displayFont)
			
			let objectOverlay = ObjectOverlay(name: string, borderRect: convertedRect, nameStringSize: size, color: inference.displayColor, font: self.displayFont)
			
			objectOverlays.append(objectOverlay)
		}
		
		// Hands off drawing to the OverlayView
		draw(objectOverlays: objectOverlays)
	}
	
	/** Calls methods to update overlay view with detected bounding boxes and class names.
	*/
	func draw(objectOverlays: [ObjectOverlay]) {
		
		ViewOverlay.objectOverlays = objectOverlays
		ViewOverlay.setNeedsDisplay()
	}
}
