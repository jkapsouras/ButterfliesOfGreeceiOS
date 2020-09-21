//
//  IntroductionViewController.swift
//  ButterfliesOfGreece
//
//  Created by Ioannis Kapsouras on 20/9/20.
//  Copyright © 2020 Ioannis Kapsouras. All rights reserved.
//

import UIKit

class IntroductionViewController: BaseController<MenuPresenter> {
	@IBOutlet weak var ViewHeader: UIView!
	@IBOutlet weak var LabelTitle: UILabel!
	@IBOutlet weak var LabelSubtitle: UILabel!
	@IBOutlet weak var TextIntro: UITextView!
	@IBOutlet weak var ViewField: UIView!
	@IBOutlet weak var ButtonField: UIButton!
	@IBOutlet weak var TextField: UITextView!
	@IBOutlet weak var ViewLegal: UIView!
	@IBOutlet weak var ButtonLegal: UIButton!
	@IBOutlet weak var TextLegal: UITextView!
	@IBOutlet weak var ViewAbout: UIView!
	@IBOutlet weak var ButtonAbout: UIButton!
	@IBOutlet weak var TextAbout: UITextView!
	@IBOutlet weak var ViewContribute: UIView!
	@IBOutlet weak var ButtonContribute: UIButton!
	@IBOutlet weak var TextContribute: UITextView!
	@IBOutlet weak var ViewEndangered: UIView!
	@IBOutlet weak var ButtonEndangered: UIButton!
	@IBOutlet weak var TextEndangered: UITextView!
	@IBOutlet weak var ViewIdentify: UIView!
	@IBOutlet weak var ButtonIdentify: UIButton!
	@IBOutlet weak var TextIdentify: UITextView!
	@IBOutlet weak var ConstHeightIntro: NSLayoutConstraint!
	@IBOutlet weak var ConstHeightField: NSLayoutConstraint!
	@IBOutlet weak var ConstHeightLegal: NSLayoutConstraint!
	@IBOutlet weak var ConstHeightAbout: NSLayoutConstraint!
	@IBOutlet weak var ConstHeightContribute: NSLayoutConstraint!
	@IBOutlet weak var ConstHeightEndangered: NSLayoutConstraint!
	@IBOutlet weak var ConstHeightIdentify: NSLayoutConstraint!
	@IBOutlet weak var ViewScroll: UIScrollView!
	
	var menuComponent:MenuComponent?
	
    override func viewDidLoad() {
        super.viewDidLoad()
		
		guard let butterfliesNavigation = navigationController as? NavigationViewController else {
			print("no proper navigation controller")
			return
		}
		
		title = Translations.Introduction
		butterfliesNavigation.setupNavigationBarAppearance(color: Constants.Colors.introduction(darkMode: false).color, textColor: Constants.Colors.introduction(darkMode: true).color, fontName: Constants.Fonts.appFont, fontSize: Constants.Fonts.titleControllerSise)
		butterfliesNavigation.setNavigationBarHidden(false, animated: true)

		view.backgroundColor = Constants.Colors.introduction(darkMode: false).color
		ViewScroll.backgroundColor = Constants.Colors.introduction(darkMode: false).color
		ViewHeader.backgroundColor = Constants.Colors.introduction(darkMode: true).color
		LabelTitle.textColor = Constants.Colors.introduction(darkMode: false).color
		LabelSubtitle.textColor = Constants.Colors.introduction(darkMode: false).color
		TextIntro.backgroundColor = Constants.Colors.introduction(darkMode: false).color
		TextIntro.textColor = Constants.Colors.introduction(darkMode: true).color
		
		ViewField.backgroundColor = Constants.Colors.introduction(darkMode: false).color
		ButtonField.backgroundColor = Constants.Colors.introduction(darkMode: true).color
		ButtonField.setTitleColor(Constants.Colors.introduction(darkMode: false).color, for: .normal)
		TextField.backgroundColor = Constants.Colors.introduction(darkMode: false).color
		TextField.textColor = Constants.Colors.introduction(darkMode: true).color
		ViewField.layer.borderWidth = 1
		ViewField.layer.borderColor = Constants.Colors.introduction(darkMode: true).color.cgColor
		
		ViewLegal.backgroundColor = Constants.Colors.introduction(darkMode: false).color
		ButtonLegal.backgroundColor = Constants.Colors.introduction(darkMode: true).color
		ButtonLegal.setTitleColor(Constants.Colors.introduction(darkMode: false).color, for: .normal)
		TextLegal.backgroundColor = Constants.Colors.introduction(darkMode: false).color
		TextLegal.textColor = Constants.Colors.introduction(darkMode: true).color
		ViewLegal.layer.borderWidth = 1
		ViewLegal.layer.borderColor = Constants.Colors.introduction(darkMode: true).color.cgColor
		
		ViewAbout.backgroundColor = Constants.Colors.introduction(darkMode: false).color
		ButtonAbout.backgroundColor = Constants.Colors.introduction(darkMode: true).color
		ButtonAbout.setTitleColor(Constants.Colors.introduction(darkMode: false).color, for: .normal)
		TextAbout.backgroundColor = Constants.Colors.introduction(darkMode: false).color
		TextAbout.textColor = Constants.Colors.introduction(darkMode: true).color
		ViewAbout.layer.borderWidth = 1
		ViewAbout.layer.borderColor = Constants.Colors.introduction(darkMode: true).color.cgColor
		
		ViewContribute.backgroundColor = Constants.Colors.introduction(darkMode: false).color
		ButtonContribute.backgroundColor = Constants.Colors.introduction(darkMode: true).color
		ButtonContribute.setTitleColor(Constants.Colors.introduction(darkMode: false).color, for: .normal)
		TextContribute.backgroundColor = Constants.Colors.introduction(darkMode: false).color
		TextContribute.textColor = Constants.Colors.introduction(darkMode: true).color
		ViewContribute.layer.borderWidth = 1
		ViewContribute.layer.borderColor = Constants.Colors.introduction(darkMode: true).color.cgColor
		
		ViewEndangered.backgroundColor = Constants.Colors.introduction(darkMode: false).color
		ButtonEndangered.backgroundColor = Constants.Colors.introduction(darkMode: true).color
		ButtonEndangered.setTitleColor(Constants.Colors.introduction(darkMode: false).color, for: .normal)
		TextEndangered.backgroundColor = Constants.Colors.introduction(darkMode: false).color
		TextEndangered.textColor = Constants.Colors.introduction(darkMode: true).color
		ViewEndangered.layer.borderWidth = 1
		ViewEndangered.layer.borderColor = Constants.Colors.introduction(darkMode: true).color.cgColor
		
		ViewIdentify.backgroundColor = Constants.Colors.introduction(darkMode: false).color
		ButtonIdentify.backgroundColor = Constants.Colors.introduction(darkMode: true).color
		ButtonIdentify.setTitleColor(Constants.Colors.introduction(darkMode: false).color, for: .normal)
		TextIdentify.backgroundColor = Constants.Colors.introduction(darkMode: false).color
		TextIdentify.textColor = Constants.Colors.introduction(darkMode: true).color
		ViewIdentify.layer.borderWidth = 1
		ViewIdentify.layer.borderColor = Constants.Colors.introduction(darkMode: true).color.cgColor
		
		LabelTitle.setFont(size: Constants.Fonts.titleControllerSise)
		LabelSubtitle.setFont(size: Constants.Fonts.fontPhotosSize)
		TextIntro.setFont(size: Constants.Fonts.fontMenuSize)
		ButtonField.setFont(size: Constants.Fonts.fontPhotosSize)
		TextField.setFont(size: Constants.Fonts.fontMenuSize)
		ButtonLegal.setFont(size: Constants.Fonts.fontPhotosSize)
		TextLegal.setFont(size: Constants.Fonts.fontMenuSize)
		ButtonAbout.setFont(size: Constants.Fonts.fontPhotosSize)
		TextAbout.setFont(size: Constants.Fonts.fontMenuSize)
		ButtonContribute.setFont(size: Constants.Fonts.fontPhotosSize)
		TextContribute.setFont(size: Constants.Fonts.fontMenuSize)
		ButtonEndangered.setFont(size: Constants.Fonts.fontPhotosSize)
		TextEndangered.setFont(size: Constants.Fonts.fontMenuSize)
		ButtonIdentify.setFont(size: Constants.Fonts.fontPhotosSize)
		TextIdentify.setFont(size: Constants.Fonts.fontMenuSize)
		
		LabelTitle.text = Translations.IntroductionTitle
		LabelSubtitle.text = Translations.IntroductionSubtitle
		TextIntro.text = Translations.IntroductionMessage
		
		ButtonField.setTitle(Translations.Field, for: .normal)
		ButtonLegal.setTitle(Translations.Legal, for: .normal)
		ButtonAbout.setTitle(Translations.About, for: .normal)
		ButtonContribute.setTitle(Translations.Contribute, for: .normal)
		ButtonEndangered.setTitle(Translations.Endangered, for: .normal)
		ButtonIdentify.setTitle(Translations.Recognition, for: .normal)
		TextField.text = Translations.IntroductionField
		TextLegal.text = Translations.IntroductionLegal
		TextAbout.text = Translations.IntroductionAbout
		TextContribute.text = Translations.IntroductionContribute
		TextEndangered.text = Translations.IntroductionEndangered
		TextIdentify.text = Translations.IntroductionRecognition
    }
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		guard let butterfliesNavigation = navigationController as? NavigationViewController else {
			print("no proper navigation controller")
			return
		}
		
		title = Translations.Introduction
		butterfliesNavigation.setupNavigationBarAppearance(color: Constants.Colors.introduction(darkMode: false).color, textColor: Constants.Colors.introduction(darkMode: true).color, fontName: Constants.Fonts.appFont, fontSize: Constants.Fonts.titleControllerSise)
		butterfliesNavigation.setNavigationBarHidden(false, animated: true)

	}
    

	override func viewWillLayoutSubviews() {
		let fixedWidthIntro = TextIntro.frame.size.width
		let newSizeIntro = TextIntro.sizeThatFits(CGSize(width: fixedWidthIntro, height: CGFloat.greatestFiniteMagnitude))
		if (newSizeIntro.height != ConstHeightIntro.constant)
		{
			ConstHeightIntro.constant = newSizeIntro.height
			view.layoutIfNeeded()
		}
		
		let fixedWidthField = TextField.frame.size.width
		let newSizeField = TextField.sizeThatFits(CGSize(width: fixedWidthField, height: CGFloat.greatestFiniteMagnitude))
		if (newSizeField.height != ConstHeightField.constant)
		{
			ConstHeightField.constant = newSizeField.height
			view.layoutIfNeeded()
		}
		
		let fixedWidthLegal = TextLegal.frame.size.width
		let newSizeLegal = TextLegal.sizeThatFits(CGSize(width: fixedWidthLegal, height: CGFloat.greatestFiniteMagnitude))
		if (newSizeLegal.height != ConstHeightLegal.constant)
		{
			ConstHeightLegal.constant = newSizeLegal.height
			view.layoutIfNeeded()
		}
		
		let fixedWidthContribute = TextAbout.frame.size.width
		let newSizeContribute = TextAbout.sizeThatFits(CGSize(width: fixedWidthContribute, height: CGFloat.greatestFiniteMagnitude))
		if (newSizeContribute.height != ConstHeightContribute.constant)
		{
			ConstHeightContribute.constant = newSizeContribute.height
			view.layoutIfNeeded()
		}
		
		let fixedWidthEndangered = TextEndangered.frame.size.width
		let newSizeEndangered = TextEndangered.sizeThatFits(CGSize(width: fixedWidthEndangered, height: CGFloat.greatestFiniteMagnitude))
		if (newSizeEndangered.height != ConstHeightEndangered.constant)
		{
			ConstHeightEndangered.constant = newSizeEndangered.height
			view.layoutIfNeeded()
		}
		
		let fixedWidthIdentity = TextLegal.frame.size.width
		let newSizeIdentity = TextLegal.sizeThatFits(CGSize(width: fixedWidthIdentity, height: CGFloat.greatestFiniteMagnitude))
		if (newSizeIdentity.height != ConstHeightIdentify.constant)
		{
			ConstHeightIdentify.constant = newSizeIdentity.height
			view.layoutIfNeeded()
		}
	}

	override func InitializeComponents() -> Array<UiComponent> {
		menuComponent = MenuComponent(field: ButtonField, contribute: ButtonContribute, about: ButtonAbout, introduction: UIButton(), endangered: ButtonEndangered, legal: ButtonLegal, recognition: ButtonIdentify)
		return [menuComponent!]
	}
}
