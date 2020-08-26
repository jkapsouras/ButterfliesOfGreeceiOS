//
//  PageModalViewController.swift
//  ButterfliesOfGreece
//
//  Created by Ioannis Kapsouras on 24/8/20.
//  Copyright © 2020 Ioannis Kapsouras. All rights reserved.
//

import UIKit

class PageModalViewController: UIPageViewController {
	var photos = ["001_001", "001_001", "001_001", "001_001", "001_001"]
	var currentIndex: Int!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		dataSource = self
		// 1
		if let viewController = viewPhotoCommentController(currentIndex ?? 0, UIStoryboard.init(name: "ModalPhoto", bundle: nil)) {
			let viewControllers = [viewController]
			
			// 2
			setViewControllers(viewControllers,
							   direction: .forward,
							   animated: false,
							   completion: nil)
		}
		
		
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
		page.photoName = photos[index]
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
	  return currentIndex ?? 0
	}
}
