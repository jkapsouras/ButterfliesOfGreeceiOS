//
//  AboutViewController.swift
//  ButterfliesOfGreece
//
//  Created by Ioannis Kapsouras on 19/9/20.
//  Copyright © 2020 Ioannis Kapsouras. All rights reserved.
//

import UIKit

class AboutViewController: UIViewController {
	@IBOutlet weak var ViewScroll: UIScrollView!
	@IBOutlet weak var ViewHeader: UIView!
	@IBOutlet weak var ImageHeader: UIImageView!
	@IBOutlet weak var LabelHeaderTitle: UILabel!
	@IBOutlet weak var LabelHeaderMessage: UILabel!
	@IBOutlet weak var TextAreaFirst: UITextView!
	@IBOutlet weak var TextAreaSecong: UITextView!
	@IBOutlet weak var TextAreaThird: UITextView!
	@IBOutlet var ViewUnderline: [UIView]!
	@IBOutlet weak var LabelSubTitle: UILabel!
	@IBOutlet weak var ConstHeightFirst: NSLayoutConstraint!
	@IBOutlet weak var ConstHeightSecond: NSLayoutConstraint!
	@IBOutlet weak var ConstHeightThird: NSLayoutConstraint!
	
	var navigationManager:NavigationManager?
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		guard let butterfliesNavigation = navigationController as? NavigationViewController else {
			print("no proper navigation controller")
			return
		}
		
		title = Translations.About
		butterfliesNavigation.setupNavigationBarAppearance(color: Constants.Colors.about(darkMode: false).color, textColor: Constants.Colors.about(darkMode: true).color, fontName: Constants.Fonts.appFont, fontSize: Constants.Fonts.titleControllerSise)
		butterfliesNavigation.setNavigationBarHidden(false, animated: true)
		
		ViewHeader.backgroundColor = Constants.Colors.about(darkMode: true).color
		LabelHeaderTitle.textColor = Constants.Colors.about(darkMode: false).color
		LabelHeaderMessage.textColor = Constants.Colors.about(darkMode: false).color
		ImageHeader.image = UIImage(imageLiteralResourceName: "butterflyIcon").withRenderingMode(.alwaysTemplate)
		ImageHeader.tintColor = Constants.Colors.about(darkMode: false).color
		
		TextAreaFirst.textColor = Constants.Colors.about(darkMode: true).color
		TextAreaFirst.backgroundColor = Constants.Colors.about(darkMode: false).color
		TextAreaSecong.textColor = Constants.Colors.about(darkMode: true).color
		TextAreaSecong.backgroundColor = Constants.Colors.about(darkMode: false).color
		TextAreaThird.textColor = Constants.Colors.about(darkMode: true).color
		TextAreaThird.backgroundColor = Constants.Colors.about(darkMode: false).color
		LabelSubTitle.textColor = Constants.Colors.about(darkMode: true).color
		ViewScroll.backgroundColor = Constants.Colors.about(darkMode: false).color
		view.backgroundColor = Constants.Colors.about(darkMode: false).color
		
		for underline in ViewUnderline{
			underline.backgroundColor = Constants.Colors.about(darkMode: true).color
		}
		
		LabelHeaderTitle.setFont(size: Constants.Fonts.titleControllerSise)
		LabelHeaderMessage.setFont(size: Constants.Fonts.fontPhotosSize)
		TextAreaFirst.setFont(size: Constants.Fonts.fontMenuSize)
		TextAreaSecong.setFont(size: Constants.Fonts.fontMenuSize)
		TextAreaThird.setFont(size: Constants.Fonts.fontMenuSize)
		LabelSubTitle.setFont(size: Constants.Fonts.fontPhotosSize)
		
		TextAreaFirst.isScrollEnabled = false
		TextAreaSecong.isScrollEnabled = false
		TextAreaThird.isScrollEnabled = false
		
		TextAreaFirst.isEditable = false
		TextAreaSecong.isEditable = false
		TextAreaThird.isEditable = false
		
		LabelHeaderTitle.text = Translations.AboutTitle
		LabelHeaderMessage.text = Translations.AboutSubtitle
		
		let linkedText = NSMutableAttributedString(string: Translations.AboutThird)
		let hyperlinked = linkedText.setAsLink(textToFind: "127557_2178_2015.pdf", linkURL: "https://yperdiavgeia.gr/decisions/downloadPdf/15680414", appFont: Constants.Fonts.appFont, fontSize: Constants.Fonts.fontMenuSize, color: Constants.Colors.about(darkMode: true).color)

		if hyperlinked {
			TextAreaThird.attributedText = NSAttributedString(attributedString: linkedText)
		}
		
		let linkedTextsecond = NSMutableAttributedString(attributedString: TextAreaThird.attributedText)
		let hyperlinkedSecond = linkedTextsecond.setAsLink(textToFind: "135366-16.pdf", linkURL: "http://www.ypeka.gr/LinkClick.aspx?fileticket=FncrrCKwYAE%3D&tabid=918&language=el-GR", appFont: Constants.Fonts.appFont, fontSize: Constants.Fonts.fontMenuSize, color: Constants.Colors.about(darkMode: true).color)

		if hyperlinkedSecond {
			TextAreaThird.attributedText = NSAttributedString(attributedString: linkedTextsecond)
		}
		
		
		TextAreaFirst.text = Translations.AboutFirst
		TextAreaSecong.text = Translations.AboutSecond
//		TextAreaThird.text = Translations.AboutThird
		
		LabelSubTitle.text = Translations.AboutThirdTitle
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		guard let butterfliesNavigation = navigationController as? NavigationViewController else {
			print("no proper navigation controller")
			return
		}
		
		title = Translations.About
		butterfliesNavigation.setupNavigationBarAppearance(color: Constants.Colors.about(darkMode: false).color, textColor: Constants.Colors.about(darkMode: true).color, fontName: Constants.Fonts.appFont, fontSize: Constants.Fonts.titleControllerSise)
		butterfliesNavigation.setNavigationBarHidden(false, animated: true)
	}
	
	override func viewWillLayoutSubviews() {
		let fixedWidthFirst = TextAreaFirst.frame.size.width
		let newSizeFirst = TextAreaFirst.sizeThatFits(CGSize(width: fixedWidthFirst, height: CGFloat.greatestFiniteMagnitude))
		if (newSizeFirst.height != ConstHeightFirst.constant)
		{
			ConstHeightFirst.constant = newSizeFirst.height
			view.layoutIfNeeded()
		}
		
		let fixedWidthSecond = TextAreaSecong.frame.size.width
		let newSizeSecond = TextAreaSecong.sizeThatFits(CGSize(width: fixedWidthSecond, height: CGFloat.greatestFiniteMagnitude))
		if (newSizeSecond.height != ConstHeightSecond.constant)
		{
			ConstHeightSecond.constant = newSizeSecond.height
			view.layoutIfNeeded()
		}
		
		let fixedWidthThird = TextAreaThird.frame.size.width
		let newSizeThird = TextAreaThird.sizeThatFits(CGSize(width: fixedWidthThird, height: CGFloat.greatestFiniteMagnitude))
		if (newSizeThird.height != ConstHeightThird.constant)
		{
			ConstHeightThird.constant = newSizeThird.height
			view.layoutIfNeeded()
		}
	}
	
}
