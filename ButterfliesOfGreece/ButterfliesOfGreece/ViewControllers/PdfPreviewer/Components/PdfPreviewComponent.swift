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
	let pdfView:PDFView
	let uiEvents: Observable<UiEvent>
    
	init(view:UIView) {
		uiEvents = Observable.never()
		
		if let pdf = view.subviews.first(where: {v in v is PDFView}){
			pdfView = pdf as! PDFView
		}
		else{
			pdfView = PDFView(frame: view.bounds)
			view.addSubview(pdfView)
		}
    }
    
    public func renderViewState(viewState: ViewState) {
		if let state = viewState as? PdfPreviewViewStates{
			switch state {
			case .showPdf(let data):
				pdfView.document = PDFDocument(data: data)
				pdfView.autoScales = true
			default:
				break
			}
		}
    }
}
