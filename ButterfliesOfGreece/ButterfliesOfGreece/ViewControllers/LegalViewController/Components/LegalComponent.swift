//
//  LegalComponent.swift
//  ButterfliesOfGreece
//
//  Created by Ioannis Kapsouras on 21/9/20.
//  Copyright © 2020 Ioannis Kapsouras. All rights reserved.
//

import Foundation
import RxSwift
import PDFKit

class LegalComponent : UiComponent
{
	let pdfView:PDFView
	let okButton:UIButton
	let termsButton:UIButton
	let formButton:UIButton
	let viewPopup:UIView
	let pdfContainer:UIView
	let uiEvents: Observable<UiEvent>
	
	init(ok:UIButton, terms:UIButton, form:UIButton, view:UIView, viewPopup:UIView) {
		self.okButton = ok
		self.termsButton = terms
		self.formButton = form
		self.viewPopup = viewPopup
		self.pdfContainer = view
		
		if let pdf = view.subviews.first(where: {v in v is PDFView}){
			pdfView = pdf as! PDFView
		}
		else{
			pdfView = PDFView()
			view.addSubview(pdfView)
			pdfView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
			pdfView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
			pdfView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
			pdfView.bottomAnchor.constraint(equalTo: termsButton.safeAreaLayoutGuide.topAnchor).isActive = true
			
		}
		pdfView.translatesAutoresizingMaskIntoConstraints = false
		pdfView.autoScales = true

		uiEvents = Observable.merge(okButton.rx.tap.map{_ in LegalEvents.okClicked},
									termsButton.rx.tap.map{_ in LegalEvents.termsClicked},
									formButton.rx.tap.map{_ in LegalEvents.formsClicked})
	}
	
	public func renderViewState(viewState: ViewState) {
		if let state = viewState as? LegalViewStates{
			switch state {
			case .showTermsPdf(document: let document):
				guard let path = Bundle.main.url(forResource: document, withExtension: "pdf") else { return }
				
				if let document = PDFDocument(url: path) {
					pdfView.document = document
				}
				pdfView.goToFirstPage(nil)
				termsButton.setTitleColor(Constants.Colors.legal(darkMode: false).color, for: .normal)
				formButton.setTitleColor(UIColor.gray, for: .normal)
			case .showFormsPdf(document: let document):
				guard let path = Bundle.main.url(forResource: document, withExtension: "pdf") else { return }
				
				if let document = PDFDocument(url: path) {
					pdfView.document = document
				}
				pdfView.goToFirstPage(nil)
				formButton.setTitleColor(Constants.Colors.legal(darkMode: false).color, for: .normal)
				termsButton.setTitleColor(UIColor.gray, for: .normal)
			case .showPopup:
				viewPopup.alpha = 1
			case .hidePopup:
				viewPopup.alpha = 0
			}
		}
		if let state = viewState as? GeneralViewState{
			switch state {
			case .idle:
				print("start loading")
			}
		}
	}
}
