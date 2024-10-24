//
//  LiveSession.swift
//  ButterfliesOfGreece
//
//  Created by Apprecot on 30/9/20.
//  Copyright © 2020 Ioannis Kapsouras. All rights reserved.
//

import UIKit
import RxSwift

class LiveSession: UIView {
	@IBOutlet weak var ButtonClose: UIButton!
	@IBOutlet weak var ViewOverlay: OverlayView!
	@IBOutlet weak var ButtonSaveImage: UIButton!
	
	private let displayFont = UIFont.systemFont(ofSize: 14.0, weight: .medium)
	private let edgeOffset: CGFloat = 2.0
	
	var contentView:UIView?
	let nibName = "LiveSession"
	var cameraSession:AVFoundationImplementation?
	let emitter:PublishSubject<UiEvent> = PublishSubject<UiEvent>()
	var UiEvents: Observable<UiEvent>{get
		{
		return Observable.merge(emitter.asObservable(),
								ButtonClose.rx.tap.map{_ in RecognitionEvents.closeLiveClicked},
								ButtonSaveImage.rx.tap.map{_ in RecognitionEvents.saveImage})
		}
	}
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		commonInit()
//		prepareTexts()
//		prepareFonts()
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
		
		cameraSession = AVFoundationImplementation(owner: contentView!, ownerSession: self)
		if let has = cameraSession?.rearCamera?.isFocusModeSupported(.continuousAutoFocus){
			if has{
				try! cameraSession?.rearCamera?.lockForConfiguration()
				cameraSession?.rearCamera?.focusMode = .continuousAutoFocus
				cameraSession?.rearCamera?.unlockForConfiguration()
			}
			else{
				try! cameraSession?.rearCamera?.lockForConfiguration()
				cameraSession?.rearCamera?.focusMode = .autoFocus
				cameraSession?.rearCamera?.unlockForConfiguration()
			}
		}
	}
	
	func loadViewFromNib() -> UIView? {
		let nib = UINib(nibName: nibName, bundle: nil)
		return nib.instantiate(withOwner: self, options: nil).first as? UIView
	}
	
	func prepareViews(){
		ButtonClose.setImage(UIImage(imageLiteralResourceName: "closeX").withRenderingMode(.alwaysTemplate), for: .normal)
		ButtonClose.tintColor = Constants.Colors.recognition(darkMode: true).color
		
		ButtonSaveImage.setTitleColor(Constants.Colors.recognition(darkMode: true).color, for: .normal)
		ButtonSaveImage.backgroundColor = Constants.Colors.recognition(darkMode: false).color
		ButtonSaveImage.layer.borderColor = Constants.Colors.recognition(darkMode: true).color.cgColor
		ButtonSaveImage.layer.borderWidth = 2
		ButtonSaveImage.layer.cornerRadius = ButtonSaveImage.frame.height/2
		ButtonSaveImage.setTitle(Translations.Save, for: .normal)
		ButtonSaveImage.setFont(size: Constants.Fonts.titleControllerSise)
	}

	func setupSession(){
		cameraSession?.setupSession()
//		cameraSession?.addText()
		cameraSession?.startSession()
	}
	
	func stopSession(){
		cameraSession?.stopSession()
	}
	
	func setImage(image:UIImage, imagePixelBuffer: CVPixelBuffer?){
		emitter.onNext(RecognitionEvents.liveImageTaken(image: image, imagePixelBuffer: imagePixelBuffer))
	}
	
	func showSaveButton(){
		ButtonSaveImage.alpha = 1
	}
	
	func hideSaveButton(){
		ButtonSaveImage.alpha = 0
	}
	
	func ClearDraws(){
		bringSubviewToFront(ViewOverlay)
		ViewOverlay.objectOverlays = []
		ViewOverlay.setNeedsDisplay()
	}
	
	func drawAfterPerformingCalculations(onInferences inferences: [DetectionInference], withImageSize imageSize:CGSize) {
		
		bringSubviewToFront(ViewOverlay)
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
