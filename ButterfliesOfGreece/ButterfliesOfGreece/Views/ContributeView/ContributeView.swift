//
//  ContributeView.swift
//  ButterfliesOfGreece
//
//  Created by Ioannis Kapsouras on 18/9/20.
//  Copyright © 2020 Ioannis Kapsouras. All rights reserved.
//

import UIKit
import RxSwift

class ContributeView: UIView {
	@IBOutlet var ViewUnderlines: [UIView]!
	@IBOutlet weak var ViewTop: UIView!
	@IBOutlet weak var LabelTitle: UILabel!
	@IBOutlet weak var LabelName: UILabel!
	@IBOutlet weak var TextName: UITextField!
	@IBOutlet weak var LabelDate: UILabel!
	@IBOutlet weak var TextDate: UITextField!
	@IBOutlet weak var LabelAltitude: UILabel!
	@IBOutlet weak var TextAltitude: UITextField!
	@IBOutlet weak var LabelPlace: UILabel!
	@IBOutlet weak var TextPlace: UITextField!
	@IBOutlet weak var LabelLatitude: UILabel!
	@IBOutlet weak var TextLatitude: UITextField!
	@IBOutlet weak var LabelLongitude: UILabel!
	@IBOutlet weak var TextLongitude: UITextField!
	@IBOutlet weak var LabelStage: UILabel!
	@IBOutlet weak var TextStage: UITextField!
	@IBOutlet weak var LabelGenusSpecie: UILabel!
	@IBOutlet weak var TextGenusSpecie: UITextField!
	@IBOutlet weak var LabelNameSpecie: UILabel!
	@IBOutlet weak var TextNameSpecie: UITextField!
	@IBOutlet weak var LabelComments: UILabel!
	@IBOutlet weak var TextComments: UITextView!
	@IBOutlet weak var ButtonAdd: UIButton!
	@IBOutlet weak var ButtonExport: UIButton!
	@IBOutlet weak var ViewDate: UIView!
	@IBOutlet weak var ViewDatePicker: UIDatePicker!
	@IBOutlet weak var ButtonDone: UIButton!
	@IBOutlet weak var ViewDateUnderline: UIView!
	
    var contentView:UIView?
	let nibName = "ContributeView"
		var UiEvents: Observable<UiEvent>{get
		{
			return ViewEvents();
			}
		}
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		commonInit()
		prepareTexts()
		prepareFonts()
		prepareViews()
		//		updateViews()
	}
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		//		commonInit()
	}
	
	func commonInit() {
		contentView = loadViewFromNib()
		contentView?.frame = self.bounds
		contentView?.autoresizingMask = UIView.AutoresizingMask(rawValue: UIView.AutoresizingMask.flexibleWidth.rawValue | UIView.AutoresizingMask.flexibleHeight.rawValue)
		
		// Adding custom subview on top of our view (over any custom drawing > see note below)
		self.addSubview(contentView!)
	}
	
	func loadViewFromNib() -> UIView? {
		let nib = UINib(nibName: nibName, bundle: nil)
		return nib.instantiate(withOwner: self, options: nil).first as? UIView
	}

	func prepareTexts(){
		LabelTitle.text = Translations.SendInfo
		LabelName.text = Translations.PhotoName
		LabelDate.text = Translations.Date
		LabelAltitude.text = Translations.Altitude
		LabelPlace.text = Translations.Place
		LabelLongitude.text = Translations.Longitude
		LabelLatitude.text = Translations.Latitude
		LabelStage.text = Translations.Stage
		LabelGenusSpecie.text = Translations.GenusSpecies
		LabelNameSpecie.text = Translations.NameSpecies
		LabelComments.text = Translations.Comments
		ButtonDone.setTitle(Translations.Done, for: .normal)
	}
	
	func prepareFonts(){
		LabelTitle.setFont(size: Constants.Fonts.titleControllerSise)
		LabelName.setFont(size: Constants.Fonts.fontMenuSize)
		LabelDate.setFont(size: Constants.Fonts.fontMenuSize)
		LabelAltitude.setFont(size: Constants.Fonts.fontMenuSize)
		LabelPlace.setFont(size: Constants.Fonts.fontMenuSize)
		LabelLongitude.setFont(size: Constants.Fonts.fontMenuSize)
		LabelLatitude.setFont(size: Constants.Fonts.fontMenuSize)
		LabelStage.setFont(size: Constants.Fonts.fontMenuSize)
		LabelGenusSpecie.setFont(size: Constants.Fonts.fontMenuSize)
		LabelNameSpecie	.setFont(size: Constants.Fonts.fontMenuSize)
		LabelComments.setFont(size: Constants.Fonts.fontMenuSize)
		 
		TextName.setFont(size: Constants.Fonts.fontMenuSize)
		TextDate.setFont(size: Constants.Fonts.fontMenuSize)
		TextAltitude.setFont(size: Constants.Fonts.fontMenuSize)
		TextPlace.setFont(size: Constants.Fonts.fontMenuSize)
		TextLongitude.setFont(size: Constants.Fonts.fontMenuSize)
		TextLatitude.setFont(size: Constants.Fonts.fontMenuSize)
		TextStage.setFont(size: Constants.Fonts.fontMenuSize)
		TextGenusSpecie.setFont(size: Constants.Fonts.fontMenuSize)
		TextNameSpecie.setFont(size: Constants.Fonts.fontMenuSize)
		TextComments.setFont(size: Constants.Fonts.fontMenuSize)
		
		ButtonDone.setFont(size: Constants.Fonts.fontMenuSize)
	}
	
	func prepareViews(){
		ViewTop.backgroundColor = Constants.Colors.contribute(darkMode: true).color
		LabelTitle.textColor = Constants.Colors.contribute(darkMode: false).color
		LabelName.textColor = Constants.Colors.contribute(darkMode: true).color
		LabelDate.textColor = Constants.Colors.contribute(darkMode: true).color
		LabelAltitude.textColor = Constants.Colors.contribute(darkMode: true).color
		LabelPlace.textColor = Constants.Colors.contribute(darkMode: true).color
		LabelLongitude.textColor = Constants.Colors.contribute(darkMode: true).color
		LabelLatitude.textColor = Constants.Colors.contribute(darkMode: true).color
		LabelStage.textColor = Constants.Colors.contribute(darkMode: true).color
		LabelGenusSpecie.textColor = Constants.Colors.contribute(darkMode: true).color
		LabelNameSpecie.textColor = Constants.Colors.contribute(darkMode: true).color
		LabelComments.textColor = Constants.Colors.contribute(darkMode: true).color
		
		TextName.textColor = Constants.Colors.contribute(darkMode: false).color
		TextDate.textColor = Constants.Colors.contribute(darkMode: false).color
		TextAltitude.textColor = Constants.Colors.contribute(darkMode: false).color
		TextPlace.textColor = Constants.Colors.contribute(darkMode: false).color
		TextLongitude.textColor = Constants.Colors.contribute(darkMode: false).color
		TextLatitude.textColor = Constants.Colors.contribute(darkMode: false).color
		TextStage.textColor = Constants.Colors.contribute(darkMode: false).color
		TextGenusSpecie.textColor = Constants.Colors.contribute(darkMode: false).color
		TextNameSpecie.textColor = Constants.Colors.contribute(darkMode: false).color
		TextComments.textColor = Constants.Colors.contribute(darkMode: false).color
		
		ButtonAdd.setTitle("", for: .normal)
		ButtonAdd.setImage(UIImage(named: "plusIcon", in: nil, compatibleWith: nil)?.withRenderingMode(.alwaysTemplate), for: .normal)
		ButtonAdd.tintColor = Constants.Colors.contribute(darkMode: true).color
		ButtonAdd.contentMode = .scaleAspectFit
		ButtonAdd.imageView?.contentMode = .scaleAspectFit
		
		ButtonExport.setTitle("", for: .normal)
		ButtonExport.setImage(UIImage(named: "shareIcon", in: nil, compatibleWith: nil)?.withRenderingMode(.alwaysTemplate), for: .normal)
		ButtonExport.tintColor = Constants.Colors.contribute(darkMode: true).color
		ButtonExport.contentMode = .scaleAspectFit
		ButtonExport.imageView?.contentMode = .scaleAspectFit
		
		ButtonDone.setTitleColor(Constants.Colors.contribute(darkMode: true).color, for: .normal)
		ViewDateUnderline.backgroundColor = Constants.Colors.contribute(darkMode: true).color
		ViewDate.backgroundColor = Constants.Colors.contribute(darkMode: false).color
		ViewDatePicker.setValue(Constants.Colors.contribute(darkMode: true).color, forKeyPath: "textColor")
		ViewDatePicker.backgroundColor = UIColor.clear
		ViewDatePicker.datePickerMode = .date
		
		for view in ViewUnderlines{
			view.backgroundColor = Constants.Colors.contribute(darkMode: true).color
		}
	}
	
	func ViewEvents() -> Observable<UiEvent>{
		return Observable.merge(TextDate.rx.controlEvent(.editingDidBegin).map{_ in
			self.TextDate.endEditing(true)
			return ContributeEvents.TextDateClicked},
								ButtonDone.rx.tap.map{_ in ContributeEvents.ButtonDoneClicked(date:  self.ViewDatePicker.date)})
	}
	
	func showDatePicker(){
		ViewDate.alpha = 1
	}
	
	func hideDatePicker(){
		ViewDate.alpha = 0
	}
	
	func setDate(date:String){
		TextDate.text = date
	}
}
