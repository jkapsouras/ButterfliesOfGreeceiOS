//
//  RecognitionViewController.swift
//  ButterfliesOfGreece
//
//  Created by Apprecot on 25/9/20.
//  Copyright © 2020 Ioannis Kapsouras. All rights reserved.
//

import UIKit

class RecognitionViewController: BaseController<RecognitionPresenter> {
	@IBOutlet weak var ButtonChoose: UIButton!
	@IBOutlet weak var ButtonTake: UIButton!
	@IBOutlet weak var ViewRecognition: RecognitionView!
	
	var imageComponent:ImageComponent?
	
	let buttonPadding:CGFloat = 16
	
    override func viewDidLoad() {
        super.viewDidLoad()
		guard let butterfliesNavigation = navigationController as? NavigationViewController else {
			print("no proper navigation controller")
			return
		}
		title = Translations.Recognition
		butterfliesNavigation.setupNavigationBarAppearance(color: Constants.Colors.recognition(darkMode: false).color, textColor: Constants.Colors.recognition(darkMode: true).color, fontName: Constants.Fonts.appFont, fontSize: Constants.Fonts.titleControllerSise)
		butterfliesNavigation.setNavigationBarHidden(false, animated: true)
    }
	
	override func viewWillDisappear(_ animated: Bool) {
		super.viewWillDisappear(animated)
		navigationController?.view.setNeedsLayout() // force update layout
		navigationController?.view.layoutIfNeeded()
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		guard let butterfliesNavigation = navigationController as? NavigationViewController else {
			print("no proper navigation controller")
			return
		}
		
		title = Translations.Recognition
		butterfliesNavigation.setupNavigationBarAppearance(color: Constants.Colors.recognition(darkMode: false).color, textColor: Constants.Colors.recognition(darkMode: true).color, fontName: Constants.Fonts.appFont, fontSize: Constants.Fonts.titleControllerSise)
		butterfliesNavigation.setNavigationBarHidden(false, animated: true)
	}
	
	override func viewWillLayoutSubviews() {
		ButtonChoose.centerVerticallyWithPadding(padding: buttonPadding)
		ButtonTake.centerVerticallyWithPadding(padding: buttonPadding)
		
		ButtonChoose.layer.cornerRadius = 16
		ButtonTake.layer.cornerRadius = 16
		
		ViewRecognition.updateViews()
	}
	
	override func InitViews() {
		if let nav = navigationController{
			nav.setNavigationBarHidden(true, animated: true)
		}
		
		ButtonChoose.layer.borderWidth=4
		ButtonChoose.layer.borderColor = Constants.Colors.recognition(darkMode: true).color.cgColor
		ButtonTake.layer.borderWidth=4
		ButtonTake.layer.borderColor = Constants.Colors.recognition(darkMode: true).color.cgColor
		
		ButtonChoose.setTitleColor(Constants.Colors.recognition(darkMode: true).color, for: .normal)
		ButtonTake.setTitleColor(Constants.Colors.recognition(darkMode: true).color, for: .normal)
		
		ButtonChoose.backgroundColor = Constants.Colors.recognition(darkMode: false).color
		ButtonTake.backgroundColor = Constants.Colors.recognition(darkMode: false).color
		
		ButtonChoose.setImage(UIImage(imageLiteralResourceName: "imageIcon").withRenderingMode(.alwaysTemplate), for: .normal)
		ButtonChoose.tintColor = Constants.Colors.recognition(darkMode: true).color
		ButtonChoose.imageView?.contentMode = .scaleAspectFit
		ButtonTake.setImage(UIImage(imageLiteralResourceName: "cameraIcon").withRenderingMode(.alwaysTemplate), for: .normal)
		ButtonTake.tintColor = Constants.Colors.recognition(darkMode: true).color
		ButtonTake.imageView?.contentMode = .scaleAspectFit
		
		view.backgroundColor = UIColor.white
	}
	
	override func LocalizeViews() {
		ButtonChoose.setTitle(Translations.ChoosePhoto, for: .normal)
		ButtonTake.setTitle(Translations.TakePhoto, for: .normal)
		
		ButtonChoose.setFont(size: Constants.Fonts.fontMenuSize)
		ButtonTake.setFont(size: Constants.Fonts.fontMenuSize)
	}
    
	override func InitializeComponents() -> Array<UiComponent> {
		imageComponent = ImageComponent(chooseButton: ButtonChoose, takeButton: ButtonTake, recognitionView: ViewRecognition, owner: self)
		return [imageComponent!]
	}

}
