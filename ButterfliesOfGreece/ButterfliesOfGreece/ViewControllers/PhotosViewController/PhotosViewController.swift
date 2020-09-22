//
//  PhotosViewController.swift
//  ButterfliesOfGreece
//
//  Created by Ioannis Kapsouras on 23/8/20.
//  Copyright © 2020 Ioannis Kapsouras. All rights reserved.
//

import UIKit

class PhotosViewController: BaseController<PhotosPresenter> {
	var photosTableComponent:PhotosTableComponent?
	var photosCollectionComponent:PhotosCollectionComponent?
	var photosHeaderComponent:PhotosHeaderComponent?
	@IBOutlet weak var ViewHeader: HeaderView!
	@IBOutlet weak var ViewPhotosTable: PhotosTableView!
	@IBOutlet weak var ViewPhotosCollection: PhotosCollectionView!
	
    override func viewDidLoad() {
		super.viewDidLoad()
		guard let butterfliesNavigation = navigationController as? NavigationViewController else {
			print("no proper navigation controller")
			return
		}
		title = "Photos" //TODO: specie name from presenter
		butterfliesNavigation.setupNavigationBarAppearance(color: Constants.Colors.field(darkMode: false).color, textColor: Constants.Colors.field(darkMode: true).color, fontName: Constants.Fonts.appFont, fontSize: Constants.Fonts.titleControllerSise)
		butterfliesNavigation.setNavigationBarHidden(false, animated: true)
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		navigationController?.view.setNeedsLayout() // force update layout
		navigationController?.view.layoutIfNeeded()
	}
	
	override func viewWillDisappear(_ animated: Bool) {
		super.viewWillDisappear(animated)
		navigationController?.view.setNeedsLayout() // force update layout
		navigationController?.view.layoutIfNeeded()
	}
	
	override func didRotate(from fromInterfaceOrientation: UIInterfaceOrientation) {
		ViewPhotosCollection.updateViews()
	}
	
	override func InitializeComponents() -> Array<UiComponent> {
		photosTableComponent = PhotosTableComponent(view: ViewPhotosTable)
		photosCollectionComponent = PhotosCollectionComponent(view: ViewPhotosCollection)
		photosHeaderComponent = PhotosHeaderComponent(view: ViewHeader)
		return [photosTableComponent!, photosCollectionComponent!, photosHeaderComponent!]
	}
}
