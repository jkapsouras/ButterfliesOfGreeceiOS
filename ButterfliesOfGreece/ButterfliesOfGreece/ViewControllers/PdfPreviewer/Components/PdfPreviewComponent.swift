//
//  PdfPreviewComponent.swift
//  ButterfliesOfGreece
//
//  Created by Ioannis Kapsouras on 16/9/20.
//  Copyright © 2020 Ioannis Kapsouras. All rights reserved.
//

import Foundation
import RxSwift
import PDFKit

class PdfPreviewComponent : UiComponent
{
	let controller:PdfPreviewViewController
	let pdfView:PDFView
	let navigationItem:UINavigationItem
	let uiEvents: Observable<UiEvent>
	let emitter:PublishSubject<UiEvent> = PublishSubject()
	let loadingView:UIActivityIndicatorView
	
	init(controller:PdfPreviewViewController, loadingView:UIActivityIndicatorView, view:UIView, navigationItem:UINavigationItem) {
		self.navigationItem = navigationItem
		self.controller = controller
		self.loadingView = loadingView
		if let pdf = view.subviews.first(where: {v in v is PDFView}){
			pdfView = pdf as! PDFView
		}
		else{
			pdfView = PDFView(frame: view.bounds)
			view.addSubview(pdfView)
		}
		pdfView.backgroundColor = Constants.Colors.field(darkMode: false).color
		uiEvents = emitter.asObservable()
		let share = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))
		self.navigationItem.setRightBarButton(share, animated: true)
		view.bringSubviewToFront(loadingView)
		loadingView.alpha=1
	}
	
	@objc func shareTapped(){
		emitter.onNext(PdfPreviewEvents.sharePdf)
	}
	
	public func renderViewState(viewState: ViewState) {
		if let state = viewState as? PdfPreviewViewStates{
			switch state {
			case .showPdf(let data):
				pdfView.document = PDFDocument(data: data)
				pdfView.autoScales = true
				loadingView.alpha=0
			case .showShareDialog(let data):
				let vc = UIActivityViewController(
					activityItems: [data],
					applicationActivities: []
				)
				controller.present(vc, animated: true, completion: nil)
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
