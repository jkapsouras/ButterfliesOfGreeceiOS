//
//  PageModalViewController.swift
//  ButterfliesOfGreece
//
//  Created by Ioannis Kapsouras on 24/8/20.
//  Copyright © 2020 Ioannis Kapsouras. All rights reserved.
//

import UIKit

class PageModalViewController: BasePageViewController<ModalPresenter>{
	var modolPhotoComponent:ModolPhotoComponent?
	var photos = [String]()
	var currentIndex = 0
	
	override func viewDidLoad() {
		super.viewDidLoad()
		dataSource = self
		guard let butterfliesNavigation = navigationController as? NavigationViewController else {
			print("no proper navigation controller")
			return
		}
		butterfliesNavigation.setNavigationBarHidden(true, animated: true)
	}
	
	func setUpPagesStartingWith(index: Int, photos:[String]){
		currentIndex = index
		self.photos = photos
		if let viewController = viewPhotoCommentController(currentIndex, UIStoryboard.init(name: "ModalPhoto", bundle: nil)) {
			let viewControllers = [viewController]
			
			// 2
			setViewControllers(viewControllers,
							   direction: .forward,
							   animated: false,
							   completion: nil)
		}
	}
	
	override func InitializeComponents() -> Array<UiComponent> {
		modolPhotoComponent = ModolPhotoComponent(view: self)
		return [modolPhotoComponent!]
	}
	
	func viewPhotoCommentController(_ index: Int, _ storyboard: UIStoryboard?) -> ModalPhotoViewController? {
		guard
			let storyboard = storyboard,
			let page = storyboard
				.instantiateViewController(withIdentifier: "ModalPhotoViewController")
				as? ModalPhotoViewController
			else {
				return nil
		}
		let tmpImage = UIImage(named: photos[index], in: nil, compatibleWith: nil)
		
		page.photoName = tmpImage != nil ? photos[index] : "default"
		page.photoIndex = index
		return page
	}
}

extension PageModalViewController: UIPageViewControllerDataSource {
	func pageViewController(
		_ pageViewController: UIPageViewController,
		viewControllerBefore viewController: UIViewController)
		-> UIViewController? {
			if let viewController = viewController as? ModalPhotoViewController,
				let index = viewController.photoIndex,
				index > 0 {
				return viewPhotoCommentController(index - 1, UIStoryboard.init(name: "ModalPhoto", bundle: nil))
			}
			return nil
	}
	
	func pageViewController(
		_ pageViewController: UIPageViewController,
		viewControllerAfter viewController: UIViewController)
		-> UIViewController? {
			if let viewController = viewController as? ModalPhotoViewController,
				let index = viewController.photoIndex,
				(index + 1) < photos.count {
				return viewPhotoCommentController(index + 1, UIStoryboard.init(name: "ModalPhoto", bundle: nil))
			}
			return nil
	}
	
	func presentationCount(for pageViewController: UIPageViewController) -> Int {
		return photos.count
	}
	
	func presentationIndex(for pageViewController: UIPageViewController) -> Int {
		return currentIndex
	}
}

