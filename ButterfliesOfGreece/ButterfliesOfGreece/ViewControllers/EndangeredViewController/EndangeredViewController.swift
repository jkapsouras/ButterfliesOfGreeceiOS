//
//  EndangeredViewController.swift
//  ButterfliesOfGreece
//
//  Created by Ioannis Kapsouras on 21/9/20.
//  Copyright © 2020 Ioannis Kapsouras. All rights reserved.
//

import UIKit
import PDFKit

class EndangeredViewController: UIViewController {
	@IBOutlet weak var ViewHeader: UIView!
	@IBOutlet weak var LabelTitle: UILabel!
	@IBOutlet weak var ViewPdf: UIView!
	
	var pdfView:PDFView?
	
    override func viewDidLoad() {
        super.viewDidLoad()

		view.backgroundColor = Constants.Colors.endangered(darkMode: false).color
		ViewHeader.backgroundColor = Constants.Colors.endangered(darkMode: true).color
		LabelTitle.textColor = Constants.Colors.endangered(darkMode: false).color
		
		LabelTitle.setFont(size: Constants.Fonts.titleControllerSise)
		
		LabelTitle.text = Translations.EndangeredTitle
		
		if let pdf = view.subviews.first(where: {v in v is PDFView}){
			pdfView = pdf as? PDFView
		}
		else{
			pdfView = PDFView()
			ViewPdf.addSubview(pdfView!)
			pdfView?.topAnchor.constraint(equalTo: ViewHeader.safeAreaLayoutGuide.bottomAnchor).isActive = true
			pdfView?.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
			pdfView?.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
			pdfView?.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
			
		}
		pdfView?.translatesAutoresizingMaskIntoConstraints = false
		pdfView?.autoScales = true
		
		guard let path = Bundle.main.url(forResource: Constants.SpeciesPdf, withExtension: "pdf") else { return }
		
		if let document = PDFDocument(url: path) {
			pdfView?.document = document
		}
		pdfView?.goToFirstPage(nil)
    }
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		guard let butterfliesNavigation = navigationController as? NavigationViewController else {
			print("no proper navigation controller")
			return
		}
		
		title = Translations.Endangered
		butterfliesNavigation.setupNavigationBarAppearance(color: Constants.Colors.endangered(darkMode: false).color, textColor: Constants.Colors.endangered(darkMode: true).color, fontName: Constants.Fonts.appFont, fontSize: Constants.Fonts.titleControllerSise)
		butterfliesNavigation.setNavigationBarHidden(false, animated: true)
	}

}
