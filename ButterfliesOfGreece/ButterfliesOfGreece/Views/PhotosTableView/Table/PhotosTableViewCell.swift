//
//  PhotosTableViewCell.swift
//  ButterfliesOfGreece
//
//  Created by Ioannis Kapsouras on 11/8/20.
//  Copyright © 2020 Ioannis Kapsouras. All rights reserved.
//

import UIKit

class PhotosTableViewCell: UITableViewCell {
	@IBOutlet weak var ImageButterfly: UIImageView!
	@IBOutlet weak var ImageAdd: UIImageView!
	@IBOutlet weak var LabelName: UILabel!
	@IBOutlet weak var ViewUnderline: UIView!
	static var Key:String = "PhotosTableViewCell"
	static var Nib:UINib = UINib.init(nibName: "PhotosTableViewCell", bundle: nil)
	
	override func awakeFromNib() {
        super.awakeFromNib()
		selectionStyle = .none
		prepareView()
    }
	
	override func draw(_ rect: CGRect) {
		ImageButterfly.layer.cornerRadius = ImageButterfly.bounds.width/2
	}

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
	func update(family: Family){
		LabelName.text = family.name
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
}
