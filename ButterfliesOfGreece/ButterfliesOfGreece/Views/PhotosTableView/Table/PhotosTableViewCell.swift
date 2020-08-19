//
//  PhotosTableViewCell.swift
//  ButterfliesOfGreece
//
//  Created by Ioannis Kapsouras on 11/8/20.
//  Copyright © 2020 Ioannis Kapsouras. All rights reserved.
//

import UIKit
import RxSwift

class PhotosTableViewCell: UITableViewCell {
	@IBOutlet weak var ImageButterfly: UIImageView!
	@IBOutlet weak var ImageAdd: UIImageView!
	@IBOutlet weak var LabelName: UILabel!
	@IBOutlet weak var ViewUnderline: UIView!
	static var Key:String = "PhotosTableViewCell"
	static var Nib:UINib = UINib.init(nibName: "PhotosTableViewCell", bundle: nil)
	
	var addRecognizer:UITapGestureRecognizer?
	var emitter:PublishSubject<UiEvent>?
	var familyId:Int?
	
	override func awakeFromNib() {
        super.awakeFromNib()
		selectionStyle = .none
		prepareView()
    }
	
	override func draw(_ rect: CGRect) {
		ImageButterfly.layer.cornerRadius = ImageButterfly.bounds.width/2
	}
    
	func update(family: Family, emitter:PublishSubject<UiEvent>){
		self.emitter = emitter
		LabelName.text = family.name
		familyId = family.id
		ImageButterfly.image = UIImage(named: "Thumbnails/\(family.photo)", in: nil, compatibleWith: nil)
		if  ImageButterfly.image == nil{
			ImageButterfly.image = #imageLiteral(resourceName: "default")
		}
		ImageAdd.image = #imageLiteral(resourceName: "plusIcon").withRenderingMode(.alwaysTemplate)
 	}
	
	func prepareView(){
		backgroundColor = Constants.Colors.appWhite.color
		LabelName.textColor = Constants.Colors.field(darkMode: true).color
		ViewUnderline.backgroundColor = Constants.Colors.field(darkMode: false).color
		LabelName.setFont(size: Constants.Fonts.fontPhotosSize)
		ImageAdd.tintColor = Constants.Colors.field(darkMode: true).color
	}
	
	func addRecognizers(){
		if (addRecognizer == nil)
		{
			addRecognizer = UITapGestureRecognizer(target: self, action: #selector(addTapped(_:)))
			ImageAdd.addGestureRecognizer(addRecognizer!)
			ImageAdd.isUserInteractionEnabled = true
		}
	}
	
	func removeRecognizers(){
		if(addRecognizer != nil){
			ImageAdd.isUserInteractionEnabled = false
			ImageAdd.removeGestureRecognizer(addRecognizer!)
			addRecognizer = nil
		}
	}
	
	@objc func addTapped(_ sender: UITapGestureRecognizer) {
		if let emitter = emitter{
			emitter.onNext(FamiliesEvents.addPhotosForPrintClicked(familyId: familyId ?? -1))
		}
	}
}
