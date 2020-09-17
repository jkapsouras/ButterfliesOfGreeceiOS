//
//  PdfPreviewViewController.swift
//  ButterfliesOfGreece
//
//  Created by Ioannis Kapsouras on 16/9/20.
//  Copyright © 2020 Ioannis Kapsouras. All rights reserved.
//

import UIKit

class PdfPreviewViewController: BaseController<PdfPreviewPresenter> {
	var pdfPreviewComponent:PdfPreviewComponent?
	
	override func viewDidLoad() {
		super.viewDidLoad()
	}
	
	override func InitializeComponents() -> Array<UiComponent> {
		pdfPreviewComponent = PdfPreviewComponent(controller:self, view: view, navigationItem: navigationItem)
		return [pdfPreviewComponent!]
	}
	
}
