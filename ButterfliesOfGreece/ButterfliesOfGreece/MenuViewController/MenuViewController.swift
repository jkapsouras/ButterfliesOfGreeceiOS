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
	
	
	var menuComponent:MenuComponent?
	
    override func viewDidLoad() {
        super.viewDidLoad()
    }
	
	override func viewWillLayoutSubviews() {
		ButtonEndangered.centerVerticallyWithPadding(padding: 8)
		ButtonField.centerVerticallyWithPadding(padding: 8)
		ButtonIntroduction.centerVerticallyWithPadding(padding: 8)
		ButtonAbout.centerVerticallyWithPadding(padding: 8)
		ButtonLegal.centerVerticallyWithPadding(padding: 8)
		ButtonContribute.centerVerticallyWithPadding(padding: 8)
		ButtonRecognition.centerVerticallyWithPadding(padding: 8)
		
		ButtonField.layer.cornerRadius = 10
		ButtonIntroduction.layer.cornerRadius = 10
		ButtonAbout.layer.cornerRadius = 10
		ButtonLegal.layer.cornerRadius = 10
		ButtonContribute.layer.cornerRadius = 10
		ButtonEndangered.layer.cornerRadius = 10
		ButtonRecognition.layer.cornerRadius = 10
	}
    
	override func InitViews() {
        ButtonField.setTitleColor(UIColor.white, for: .normal)
		ButtonIntroduction.setTitleColor(UIColor.white, for: .normal)
		ButtonAbout.setTitleColor(UIColor.white, for: .normal)
		ButtonLegal.setTitleColor(UIColor.white, for: .normal)
		ButtonContribute.setTitleColor(UIColor.white, for: .normal)
		ButtonEndangered.setTitleColor(UIColor.white, for: .normal)
		ButtonRecognition.setTitleColor(UIColor.white, for: .normal)
		
		ButtonField.backgroundColor = Constants.Colors.field.color
		ButtonIntroduction.backgroundColor = Constants.Colors.introduction.color
		ButtonAbout.backgroundColor = Constants.Colors.about.color
		ButtonLegal.backgroundColor = Constants.Colors.legal.color
		ButtonContribute.backgroundColor = Constants.Colors.contribute.color
		ButtonEndangered.backgroundColor = Constants.Colors.endangered.color
		ButtonRecognition.backgroundColor = Constants.Colors.recognition.color
		
		
		ButtonField.setImage(#imageLiteral(resourceName: "butterflyIcon").withRenderingMode(.alwaysTemplate), for: .normal)
		ButtonField.tintColor = UIColor.white
		ButtonIntroduction.setImage(#imageLiteral(resourceName: "introIcon").withRenderingMode(.alwaysTemplate), for: .normal)
		ButtonIntroduction.tintColor = UIColor.white
		ButtonAbout.setImage(#imageLiteral(resourceName: "aboutIcon").withRenderingMode(.alwaysTemplate), for: .normal)
		ButtonAbout.tintColor = UIColor.white
		ButtonLegal.setImage(#imageLiteral(resourceName: "legalIcon").withRenderingMode(.alwaysTemplate), for: .normal)
		ButtonLegal.tintColor = UIColor.white
		ButtonContribute.setImage(#imageLiteral(resourceName: "contributeIcon").withRenderingMode(.alwaysTemplate), for: .normal)
		ButtonContribute.tintColor = UIColor.white
		ButtonEndangered.setImage(#imageLiteral(resourceName: "endangeredIcon").withRenderingMode(.alwaysTemplate), for: .normal)
		ButtonEndangered.tintColor = UIColor.white
		ButtonRecognition.setImage(#imageLiteral(resourceName: "searchIcon").withRenderingMode(.alwaysTemplate), for: .normal)
		ButtonRecognition.tintColor = UIColor.white
		
    }
    
    override func LocalizeViews() {
        ButtonField.setTitle(Translations.Field, for: .normal)
		ButtonIntroduction.setTitle(Translations.Introduction, for: .normal)
		ButtonAbout.setTitle(Translations.About, for: .normal)
		ButtonLegal.setTitle(Translations.Legal, for: .normal)
		ButtonContribute.setTitle(Translations.Contribute, for: .normal)
		ButtonEndangered.setTitle(Translations.Endangered, for: .normal)
		ButtonRecognition.setTitle(Translations.Recognition, for: .normal)
	}
    
    override func InitializeComponents() -> Array<UiComponent> {
        menuComponent = MenuComponent(field: ButtonField)
        return [menuComponent!]
    }
}
