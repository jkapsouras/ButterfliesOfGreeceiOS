//
//  MenuViewController.swift
//  ButterfliesOfGreece
//
//  Created by Ioannis Kapsouras on 5/7/20.
//  Copyright © 2020 Ioannis Kapsouras. All rights reserved.
//

import UIKit
import RxCocoa

class MenuViewController: BaseController<MenuPresenter> {
	@IBOutlet weak var ButtonField: UIButton!
	@IBOutlet weak var ButtonIntroduction: UIButton!
	@IBOutlet weak var ButtonAbout: UIButton!
	@IBOutlet weak var ButtonLegal: UIButton!
	@IBOutlet weak var ButtonContribute: UIButton!
	@IBOutlet weak var ButtonEndangered: UIButton!
	@IBOutlet weak var ButtonRecognition: UIButton!
	
	let imageSize = CGSize(width: 32,height: 32)
	let buttonPadding:CGFloat = 16
	
	var menuComponent:MenuComponent?
	
    override func viewDidLoad() {
        super.viewDidLoad()
		title = ""
    }
	
	override func viewWillLayoutSubviews() {
		ButtonEndangered.centerVerticallyWithPadding(padding: buttonPadding)
		ButtonField.centerVerticallyWithPadding(padding: buttonPadding)
		ButtonIntroduction.centerVerticallyWithPadding(padding: buttonPadding)
		ButtonAbout.centerVerticallyWithPadding(padding: buttonPadding)
		ButtonLegal.centerVerticallyWithPadding(padding: buttonPadding)
		ButtonContribute.centerVerticallyWithPadding(padding: buttonPadding)
		ButtonRecognition.centerVerticallyWithPadding(padding: buttonPadding)
		
		ButtonField.layer.cornerRadius = 16
		ButtonIntroduction.layer.cornerRadius = 16
		ButtonAbout.layer.cornerRadius = 16
		ButtonLegal.layer.cornerRadius = 16
		ButtonContribute.layer.cornerRadius = 16
		ButtonEndangered.layer.cornerRadius = 16
		ButtonRecognition.layer.cornerRadius = 16
	}
    
	override func InitViews() {
		if let nav = navigationController{
			nav.setNavigationBarHidden(true, animated: true)
		}
		
		ButtonField.layer.borderWidth=4
		ButtonField.layer.borderColor = Constants.Colors.field(darkMode: true).color.cgColor
		ButtonIntroduction.layer.borderWidth=4
		ButtonIntroduction.layer.borderColor = Constants.Colors.introduction(darkMode: true).color.cgColor
		ButtonAbout.layer.borderWidth=4
		ButtonAbout.layer.borderColor = Constants.Colors.about(darkMode: true).color.cgColor
		ButtonLegal.layer.borderWidth=4
		ButtonLegal.layer.borderColor = Constants.Colors.legal(darkMode: true).color.cgColor
		ButtonContribute.layer.borderWidth=4
		ButtonContribute.layer.borderColor = Constants.Colors.contribute(darkMode: true).color.cgColor
		ButtonEndangered.layer.borderWidth=4
		ButtonEndangered.layer.borderColor = Constants.Colors.endangered(darkMode: true).color.cgColor
		ButtonRecognition.layer.borderWidth=4
		ButtonRecognition.layer.borderColor = Constants.Colors.recognition(darkMode: true).color.cgColor
		
		ButtonField.setTitleColor(Constants.Colors.field(darkMode: true).color, for: .normal)
		ButtonIntroduction.setTitleColor(Constants.Colors.introduction(darkMode: true).color, for: .normal)
		ButtonAbout.setTitleColor(Constants.Colors.about(darkMode: true).color, for: .normal)
		ButtonLegal.setTitleColor(Constants.Colors.legal(darkMode: true).color, for: .normal)
		ButtonContribute.setTitleColor(Constants.Colors.contribute(darkMode: true).color, for: .normal)
		ButtonEndangered.setTitleColor(Constants.Colors.endangered(darkMode: true).color, for: .normal)
		ButtonRecognition.setTitleColor(Constants.Colors.recognition(darkMode: true).color, for: .normal)
		
		ButtonField.backgroundColor = Constants.Colors.field(darkMode: false).color
		ButtonIntroduction.backgroundColor = Constants.Colors.introduction(darkMode: false).color
		ButtonAbout.backgroundColor = Constants.Colors.about(darkMode: false).color
		ButtonLegal.backgroundColor = Constants.Colors.legal(darkMode: false).color
		ButtonContribute.backgroundColor = Constants.Colors.contribute(darkMode: false).color
		ButtonEndangered.backgroundColor = Constants.Colors.endangered(darkMode: false).color
		ButtonRecognition.backgroundColor = Constants.Colors.recognition(darkMode: false).color
		
		ButtonField.setImage(#imageLiteral(resourceName: "butterflyIcon").withRenderingMode(.alwaysTemplate), for: .normal)
		ButtonField.tintColor = Constants.Colors.field(darkMode: true).color
		ButtonField.imageView?.contentMode = .scaleAspectFit
		ButtonIntroduction.setImage(#imageLiteral(resourceName: "introIcon").withRenderingMode(.alwaysTemplate), for: .normal)
		ButtonIntroduction.tintColor = Constants.Colors.introduction(darkMode: true).color
		ButtonIntroduction.imageView?.contentMode = .scaleAspectFit
		ButtonAbout.setImage(#imageLiteral(resourceName: "aboutIcon").withRenderingMode(.alwaysTemplate), for: .normal)
		ButtonAbout.tintColor = Constants.Colors.about(darkMode: true).color
		ButtonAbout.imageView?.contentMode = .scaleAspectFit
		ButtonLegal.setImage(#imageLiteral(resourceName: "legalIcon").withRenderingMode(.alwaysTemplate), for: .normal)
		ButtonLegal.tintColor = Constants.Colors.legal(darkMode: true).color
		ButtonLegal.imageView?.contentMode = .scaleAspectFit
		ButtonContribute.setImage(#imageLiteral(resourceName: "contributeIcon").withRenderingMode(.alwaysTemplate), for: .normal)
		ButtonContribute.tintColor = Constants.Colors.contribute(darkMode: true).color
		ButtonContribute.imageView?.contentMode = .scaleAspectFit
		ButtonEndangered.setImage(#imageLiteral(resourceName: "endangeredIcon").withRenderingMode(.alwaysTemplate), for: .normal)
		ButtonEndangered.tintColor = Constants.Colors.endangered(darkMode: true).color
		ButtonEndangered.imageView?.contentMode = .scaleAspectFit
		ButtonRecognition.setImage(#imageLiteral(resourceName: "recognitionIcon").withRenderingMode(.alwaysTemplate), for: .normal)
		ButtonRecognition.tintColor = Constants.Colors.recognition(darkMode: true).color
		ButtonRecognition.imageView?.contentMode = .scaleAspectFit
    }
    
    override func LocalizeViews() {
        ButtonField.setTitle(Translations.Field, for: .normal)
		ButtonIntroduction.setTitle(Translations.Introduction, for: .normal)
		ButtonAbout.setTitle(Translations.About, for: .normal)
		ButtonLegal.setTitle(Translations.Legal, for: .normal)
		ButtonContribute.setTitle(Translations.Contribute, for: .normal)
		ButtonEndangered.setTitle(Translations.Endangered, for: .normal)
		ButtonRecognition.setTitle(Translations.Recognition, for: .normal)
		
		ButtonField.setFont(size: Constants.Fonts.fontMenuSize)
		ButtonIntroduction.setFont(size: Constants.Fonts.fontMenuSize)
		ButtonAbout.setFont(size: Constants.Fonts.fontMenuSize)
		ButtonLegal.setFont(size: Constants.Fonts.fontMenuSize)
		ButtonContribute.setFont(size: Constants.Fonts.fontMenuSize)
		ButtonEndangered.setFont(size: Constants.Fonts.fontMenuSize)
		ButtonRecognition.setFont(size: Constants.Fonts.fontMenuSize)
	}
    
    override func InitializeComponents() -> Array<UiComponent> {
        menuComponent = MenuComponent(field: ButtonField, contribute: ButtonContribute)
        return [menuComponent!]
    }
}
