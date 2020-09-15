//
//  PickerDataModel.swift
//  ButterfliesOfGreece
//
//  Created by Ioannis Kapsouras on 15/9/20.
//  Copyright © 2020 Ioannis Kapsouras. All rights reserved.
//

import Foundation
import UIKit
import RxSwift

class PickerDataModel : NSObject, UIPickerViewDelegate, UIPickerViewDataSource
{
	var arranges:[PdfArrange]
	var selectedArrange:PdfArrange
	
	init(selectedArrange:PdfArrange)
	{
		arranges = [PdfArrange]()
		arranges.append(PdfArrange.onePerPage)
		arranges.append(PdfArrange.twoPerPage)
		arranges.append(PdfArrange.fourPerPage)
		arranges.append(PdfArrange.sixPerPage)
		self.selectedArrange = selectedArrange
		super.init()
	}
	
	func findSelectedRow(currentArrange:PdfArrange) -> Int{
		return arranges.firstIndex(of: currentArrange) ?? 0
	}
	
	func numberOfComponents(in pickerView: UIPickerView) -> Int {
		return 1
	}
	
	func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
		return arranges.count
	}
	
	func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
		let lbl:UILabel = UILabel(frame: CGRect(x: 0,y: 0,width: pickerView.bounds.width, height: 30))
		lbl.textAlignment = .center
		lbl.textColor = Constants.Colors.field(darkMode: false).color
		lbl.setFont(size: Constants.Fonts.fontMenuSize)
		lbl.text = arranges[row].toString()
		lbl.adjustsFontSizeToFitWidth = true
		return lbl
	}
	
	func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
		return 40
	}
	
	func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
		selectedArrange = arranges[row]
	}
}
