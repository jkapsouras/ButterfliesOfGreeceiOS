//
//  PrintToPdfViewController.swift
//  ButterfliesOfGreece
//
//  Created by Ioannis Kapsouras on 13/9/20.
//  Copyright © 2020 Ioannis Kapsouras. All rights reserved.
//

import UIKit

class PrintToPdfViewController: BaseController<PrintToPdfPresenter> {
	var photosToPrintComponent:PhotosToPrintComponent?
	
	@IBOutlet weak var ViewHeader: HeaderPrintToPdfView!
	@IBOutlet weak var ViewPhotos: PhotosTableView!
	
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

   override func InitializeComponents() -> Array<UiComponent> {
		photosToPrintComponent = PhotosToPrintComponent(view: ViewPhotos)
		return [photosToPrintComponent!]
	}

}
