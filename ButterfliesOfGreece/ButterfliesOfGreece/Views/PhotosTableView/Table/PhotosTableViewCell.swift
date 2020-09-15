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
	var specieId:Int?
	var photoId:Int?
	var photo:ButterflyPhoto?
	var showingStep:ShowingStep?
	
	override func awakeFromNib() {
		super.awakeFromNib()
		selectionStyle = .none
		prepareView()
	}
	
	override func draw(_ rect: CGRect) {
		ImageButterfly.layer.cornerRadius = ImageButterfly.bounds.width/2
	}
	
	func update(family: Family, emitter:PublishSubject<UiEvent>, showingStep:ShowingStep){
		self.showingStep = showingStep
		self.emitter = emitter
		LabelName.text = family.name
		familyId = family.id
		ImageButterfly.image = UIImage(named: "Thumbnails/\(family.photo)", in: nil, compatibleWith: nil)
		if  ImageButterfly.image == nil{
			ImageButterfly.image = #imageLiteral(resourceName: "default")
		}
		ImageAdd.image = #imageLiteral(resourceName: "plusIcon").withRenderingMode(.alwaysTemplate)
	}
	
	func update(specie: Specie, emitter:PublishSubject<UiEvent>, showingStep:ShowingStep, fromSearch: Bool){
		self.showingStep = showingStep
		self.emitter = emitter
		LabelName.text = specie.name
		specieId = specie.id
		ImageButterfly.image = UIImage(named: "Thumbnails/\(specie.imageTitle)", in: nil, compatibleWith: nil)
		if  ImageButterfly.image == nil{
			ImageButterfly.image = #imageLiteral(resourceName: "default")
		}
		ImageAdd.image = #imageLiteral(resourceName: "plusIcon").withRenderingMode(.alwaysTemplate)
		ImageAdd.alpha = fromSearch ? 0 : 1
	}
	
	func update(photo: ButterflyPhoto, emitter:PublishSubject<UiEvent>, showingStep:ShowingStep){
		self.showingStep = showingStep
		self.emitter = emitter
		LabelName.text = "\(Translations.Photographer): \(photo.author)"
		photoId = photo.id
		self.photo = photo
		ImageButterfly.image = UIImage(named: "Thumbnails/\(photo.source)", in: nil, compatibleWith: nil)
		if  ImageButterfly.image == nil{
			ImageButterfly.image = #imageLiteral(resourceName: "default")
		}
		ImageAdd.image = showingStep == ShowingStep.photos ?  #imageLiteral(resourceName: "plusIcon").withRenderingMode(.alwaysTemplate) : #imageLiteral(resourceName: "minusIcon").withRenderingMode(.alwaysTemplate)
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
			switch showingStep {
			case .families:
				emitter.onNext(FamiliesEvents.addPhotosForPrintClicked(familyId: familyId ?? -1))
			case .species:
				emitter.onNext(SpeciesEvents.addPhotosForPrintClicked(specieId: specieId ?? -1))
			case .photos:
				emitter.onNext(PhotosEvents.addPhotoForPrintClicked(photoId: photoId ?? -1))
			case .photosToPrint:
				if let photo = photo{
					emitter.onNext(PrintToPdfEvents.delete(photo: photo))
				}
			case .none:
				print("do nothing")
			}
		}
	}
}
