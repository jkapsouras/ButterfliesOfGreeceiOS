//
//  PhotosToPrintHeaderComponent.swift
//  ButterfliesOfGreece
//
//  Created by Ioannis Kapsouras on 15/9/20.
//  Copyright © 2020 Ioannis Kapsouras. All rights reserved.
//

import Foundation
import RxSwift

class PhotosToPrintHeaderComponent : UiComponent
{
	let headerView:HeaderPrintToPdfView
	let buttonDone:UIButton
	let pikcerContainerView:UIView
	let pickerView:UIPickerView
	var model:PickerDataModel
	
	let uiEvents: Observable<UiEvent>
    
	init(headerView:HeaderPrintToPdfView, buttonDone:UIButton, pickerContainerView:UIView, pickerView:UIPickerView, model:PickerDataModel) {
		self.headerView = headerView
		self.buttonDone = buttonDone
		self.pikcerContainerView = pickerContainerView
		self.pickerView = pickerView
		self.model = model
		uiEvents = Observable.merge(headerView.UiEvents, buttonDone.rx.tap.map{_ in
			model.done()})
    }
	
    public func renderViewState(viewState: ViewState) {
		if let state = viewState as? PrintToPdfViewStates{
			switch state {
			case PrintToPdfViewStates.showNumberOfPhotos(let data):
				headerView.ShowPhotosToPrint(numberOfPhotos: data)
			case PrintToPdfViewStates.showPickArrangeView(let currentArrange):
				pikcerContainerView.alpha = 1
				model.selectedArrange = currentArrange
				pickerView.dataSource = model
				pickerView.delegate = model
				pickerView.selectRow(model.findSelectedRow(currentArrange: currentArrange), inComponent: 0, animated: true)
			case PrintToPdfViewStates.arrangeViewChanged(let arrange):
				headerView.showArrange(arrange:arrange)
				pikcerContainerView.alpha=0;
			default:
				break
			}
		}
    }
}
