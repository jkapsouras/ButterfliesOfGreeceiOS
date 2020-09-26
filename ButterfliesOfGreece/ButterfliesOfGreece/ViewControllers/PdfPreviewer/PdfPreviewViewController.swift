//
//  PdfPreviewViewController.swift
//  ButterfliesOfGreece
//
//  Created by Ioannis Kapsouras on 16/9/20.
//  Copyright © 2020 Ioannis Kapsouras. All rights reserved.
//

import UIKit

class PdfPreviewViewController: BaseController<PdfPreviewPresenter> {
	@IBOutlet weak var LoadingSpinner: UIActivityIndicatorView!
	var pdfPreviewComponent:PdfPreviewComponent?
	
	override func viewDidLoad() {
		super.viewDidLoad()
		LoadingSpinner.color = Constants.Colors.field(darkMode: true).color
		view.backgroundColor = Constants.Colors.field(darkMode: false).color
		LoadingSpinner.startAnimating()
	}
	
	override func InitializeComponents() -> Array<UiComponent> {
		pdfPreviewComponent = PdfPreviewComponent(controller:self, loadingView: LoadingSpinner, view: view, navigationItem: navigationItem)
		return [pdfPreviewComponent!]
	}
	
}
