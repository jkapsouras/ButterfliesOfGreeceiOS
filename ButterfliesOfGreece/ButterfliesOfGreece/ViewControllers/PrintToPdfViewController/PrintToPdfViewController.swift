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
	var photosToPrintHeaderComponent:PhotosToPrintHeaderComponent?
	
	@IBOutlet weak var ViewHeader: HeaderPrintToPdfView!
	@IBOutlet weak var ViewPhotos: PhotosTableView!
	@IBOutlet weak var ViewPickerContainer: UIView!
	@IBOutlet weak var ViewPicker: UIPickerView!
	@IBOutlet weak var ButtonDone: UIButton!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		ViewPickerContainer.backgroundColor = Constants.Colors.field(darkMode: true).color
		ViewPicker.backgroundColor = Constants.Colors.field(darkMode: true).color
		ButtonDone.setTitleColor(Constants.Colors.field(darkMode: false).color, for: .normal)
		ButtonDone.setTitle(Translations.Select, for: .normal)
		// Do any additional setup after loading the view.
	}
	
	
	override func InitializeComponents() -> Array<UiComponent> {
		photosToPrintComponent = PhotosToPrintComponent(view: ViewPhotos)
		photosToPrintHeaderComponent = PhotosToPrintHeaderComponent(headerView: ViewHeader, buttonDone: ButtonDone, pickerContainerView: ViewPickerContainer, pickerView: ViewPicker, model: PickerDataModel(selectedArrange: PdfArrange.onePerPage))
		return [photosToPrintComponent!, photosToPrintHeaderComponent!]
	}
	
}
