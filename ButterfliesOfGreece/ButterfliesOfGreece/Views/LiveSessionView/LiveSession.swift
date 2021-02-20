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
	
	var contentView:UIView?
	let nibName = "LiveSession"
	var cameraSession:AVFoundationImplementation?
	let emitter:PublishSubject<UiEvent> = PublishSubject<UiEvent>()
	var UiEvents: Observable<UiEvent>{get
		{
		return Observable.merge(emitter.asObservable(),
								ButtonClose.rx.tap.map{_ in RecognitionEvents.closeLiveClicked})
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
	}
	
	func loadViewFromNib() -> UIView? {
		let nib = UINib(nibName: nibName, bundle: nil)
		return nib.instantiate(withOwner: self, options: nil).first as? UIView
	}
	
	func prepareViews(){
		ButtonClose.setImage(UIImage(imageLiteralResourceName: "closeX").withRenderingMode(.alwaysTemplate), for: .normal)
		ButtonClose.tintColor = Constants.Colors.recognition(darkMode: true).color
	}

	func setupSession(){
		cameraSession?.setupSession()
		cameraSession?.addText()
		cameraSession?.startSession()
	}
	
	func stopSession(){
		cameraSession?.stopSession()
	}
	
	func setImage(image:UIImage, imagePixelBuffer: CVPixelBuffer?){
		emitter.onNext(RecognitionEvents.liveImageTaken(image: image, imagePixelBuffer: imagePixelBuffer))
	}
	
	func setTextToSession(text:String){
		cameraSession?.setText(text: text)
	}
}
