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
	
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
	func update(family: Family){
		LabelName.text = family.name
		ImageButterfly.image = UIImage(named: family.photo, in: nil, compatibleWith: nil)
 	}
	
	func prepareView(){
		
	}
}
