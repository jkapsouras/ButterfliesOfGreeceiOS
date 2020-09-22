//
//  ModalPhotoViewController.swift
//  ButterfliesOfGreece
//
//  Created by Ioannis Kapsouras on 23/8/20.
//  Copyright © 2020 Ioannis Kapsouras. All rights reserved.
//

import UIKit

class ModalPhotoViewController: UIViewController {
	@IBOutlet weak var ViewScroll: UIScrollView!
	@IBOutlet weak var ImagePhoto: UIImageView!
	@IBOutlet weak var ConstImageLeading: NSLayoutConstraint!
	@IBOutlet weak var ConstImageTop: NSLayoutConstraint!
	@IBOutlet weak var ConstImageTrailing: NSLayoutConstraint!
	@IBOutlet weak var ConstImageBottom: NSLayoutConstraint!
	@IBOutlet weak var ButtonClose: UIButton!
	
	@IBAction func CloseTap(_ sender: UIButton) {
		dismiss(animated: true, completion: nil)
	}
	var photoName: String?
	var photoIndex: Int?
	
    override func viewDidLoad() {
        super.viewDidLoad()
		ViewScroll.delegate = self
        // Do any additional setup after loading the view.
		view.backgroundColor = Constants.Colors.field(darkMode: false).color
		ViewScroll.backgroundColor = Constants.Colors.field(darkMode: false).color
		ImagePhoto.contentMode = .scaleAspectFit
		ViewScroll.contentMode = .scaleAspectFit
		ViewScroll.clipsToBounds = true
		ButtonClose.setImage(UIImage(imageLiteralResourceName: "closeX").withRenderingMode(.alwaysTemplate), for: .normal)
		ButtonClose.tintColor = Constants.Colors.field(darkMode: true).color
    }
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		ImagePhoto.image = UIImage(named: photoName ?? "default", in: nil, compatibleWith: nil)
	}
	
	override func viewWillLayoutSubviews() {
	  super.viewWillLayoutSubviews()
		if let zoomImage = ImagePhoto.image {
		  updateMinZoomScaleForSize(zoomImage.size)
	  }
	}
	
	func updateMinZoomScaleForSize(_ imageSize: CGSize) {
	  // Scale the image down to fit in the view
	  ViewScroll.minimumZoomScale = 1
		ViewScroll.maximumZoomScale = 4*1
	  ViewScroll.zoomScale = 1
		
		view.layoutIfNeeded()
	  
	  // Set the image frame size after scaling down
//	  let imageWidth = imageSize.width * minScale
//	  let imageHeight = imageSize.height * minScale
//	  let newImageFrame = CGRect(x: 0, y: 0, width: imageWidth, height: imageHeight)
//	  ImagePhoto.frame = newImageFrame
	  
//	  centerImage()
	}
	
//	private func centerImage() {
////		let imageViewSize = ImagePhoto.frame.size
////		let scrollViewSize = view.frame.size
////		let verticalPadding = imageViewSize.height < scrollViewSize.height ? (scrollViewSize.height - imageViewSize.height) / 2 : 0
////		let horizontalPadding = imageViewSize.width < scrollViewSize.width ? (scrollViewSize.width - imageViewSize.width) / 2 : 0
////
////		ViewScroll.contentInset = UIEdgeInsets(top: verticalPadding, left: horizontalPadding, bottom: verticalPadding, right: horizontalPadding)
//	}

    //1
//	func scrollViewDidZoom(_ scrollView: UIScrollView) {
//	  updateConstraintsForSize(view.bounds.size)
//	}
//
//	//2
//	func updateConstraintsForSize(_ size: CGSize) {
//	  //3
//	  let yOffset = max(0, (size.height - ImagePhoto.frame.height) / 2)
//	  ConstImageTop.constant = yOffset
//	  ConstImageBottom.constant = yOffset
//
//	  //4
//	  let xOffset = max(0, (size.width - ImagePhoto.frame.width) / 2)
//	  ConstImageLeading.constant = xOffset
//	  ConstImageTrailing.constant = xOffset
//
//	  view.layoutIfNeeded()
//	}

}

extension ModalPhotoViewController: UIScrollViewDelegate {
  func viewForZooming(in scrollView: UIScrollView) -> UIView? {
    return ImagePhoto
  }
}
