//
//  LegalViewController.swift
//  ButterfliesOfGreece
//
//  Created by Ioannis Kapsouras on 20/9/20.
//  Copyright © 2020 Ioannis Kapsouras. All rights reserved.
//

import UIKit

class LegalViewController: BaseController<LegalPresenter> {
	@IBOutlet weak var ViewPopup: UIView!
	@IBOutlet weak var ViewPopupInside: UIView!
	@IBOutlet weak var ButtonOk: UIButton!
	@IBOutlet weak var TextInside: UITextView!
	@IBOutlet weak var ButtonTerms: UIButton!
	@IBOutlet weak var ButtonForm: UIButton!
	@IBOutlet weak var ConstHeightPopup: NSLayoutConstraint!
	@IBOutlet weak var ViewPdf: UIView!
	
	var legalComponent:LegalComponent?
	
    override func viewDidLoad() {
        super.viewDidLoad()

		ViewPopup.backgroundColor = UIColor.black.withAlphaComponent(0.2)
		ViewPopupInside.backgroundColor = Constants.Colors.legal(darkMode: false).color
		TextInside.backgroundColor = Constants.Colors.legal(darkMode: false).color
		TextInside.textColor = Constants.Colors.legal(darkMode: true).color
		ButtonOk.backgroundColor = Constants.Colors.legal(darkMode: true).color
		ButtonOk.setTitleColor(Constants.Colors.legal(darkMode: false).color, for: .normal)
		ButtonTerms.backgroundColor = Constants.Colors.legal(darkMode: true).color
		ButtonForm.backgroundColor = Constants.Colors.legal(darkMode: true).color
		ButtonTerms.setTitleColor(Constants.Colors.legal(darkMode: false).color, for: .normal)
		ButtonForm.setTitleColor(Constants.Colors.legal(darkMode: false).color, for: .normal)
		
		TextInside.setFont(size: Constants.Fonts.fontMenuSize)
		ButtonOk.setFont(size: Constants.Fonts.fontPhotosSize)
		ButtonTerms.setFont(size: Constants.Fonts.fontPhotosSize)
		ButtonForm.setFont(size: Constants.Fonts.fontPhotosSize)
		
		let linkedTextPdf = NSMutableAttributedString(string: Translations.LegalPopup)
		let hyperlinkedPdf = linkedTextPdf.setAsLink(textToFind: Translations.Pdf, linkURL: "https://yperdiavgeia.gr/decisions/downloadPdf/15680414", appFont: Constants.Fonts.appFont, fontSize: Constants.Fonts.fontMenuSize, color: Constants.Colors.legal(darkMode: true).color)

		if hyperlinkedPdf {
			TextInside.attributedText = NSAttributedString(attributedString: linkedTextPdf)
		}

		let linkedTextMinistry = NSMutableAttributedString(attributedString: TextInside.attributedText)
		let hyperlinkedMinistry = linkedTextMinistry.setAsLink(textToFind: Translations.Ministry, linkURL: "http://www.ypeka.gr/Default.aspx?tabid=918&language=en-US", appFont: Constants.Fonts.appFont, fontSize: Constants.Fonts.fontMenuSize, color: Constants.Colors.legal(darkMode: true).color)

		if hyperlinkedMinistry {
			TextInside.attributedText = NSAttributedString(attributedString: linkedTextMinistry)
		}

		let linkedTextHere = NSMutableAttributedString(attributedString: TextInside.attributedText)
		let hyperlinkedHere = linkedTextHere.setAsLink(textToFind: Translations.Here, linkURL: "http://www.ypeka.gr/LinkClick.aspx?fileticket=FncrrCKwYAE%3D&tabid=918&language=el-GR", appFont: Constants.Fonts.appFont, fontSize: Constants.Fonts.fontMenuSize, color: Constants.Colors.legal(darkMode: true).color)

		if hyperlinkedHere {
			TextInside.attributedText = NSAttributedString(attributedString: linkedTextHere)
		}
		
		ButtonOk.setTitle(Translations.Ok, for: .normal)
		ButtonTerms.setTitle(Translations.Terms, for: .normal)
		ButtonForm.setTitle(Translations.Form, for: .normal)
    }
    
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		guard let butterfliesNavigation = navigationController as? NavigationViewController else {
			print("no proper navigation controller")
			return
		}
		
		title = Translations.Legal
		butterfliesNavigation.setupNavigationBarAppearance(color: Constants.Colors.legal(darkMode: false).color, textColor: Constants.Colors.legal(darkMode: true).color, fontName: Constants.Fonts.appFont, fontSize: Constants.Fonts.titleControllerSise)
		butterfliesNavigation.setNavigationBarHidden(false, animated: true)

	}
	
	override func viewWillLayoutSubviews() {
		let fixedWidthPopup = TextInside.frame.size.width
		let newSizePopup = TextInside.sizeThatFits(CGSize(width: fixedWidthPopup, height: CGFloat.greatestFiniteMagnitude))
		if (newSizePopup.height != ConstHeightPopup.constant)
		{
			ConstHeightPopup.constant = newSizePopup.height
			view.layoutIfNeeded()
		}
	}
	
	override func InitializeComponents() -> Array<UiComponent> {
		legalComponent = LegalComponent(ok: ButtonOk, terms: ButtonTerms, form: ButtonForm, view: ViewPdf, viewPopup: ViewPopup)
		return [legalComponent!]
	}
}
