//
//  FamiliesViewController.swift
//  ButterfliesOfGreece
//
//  Created by Ioannis Kapsouras on 7/8/20.
//  Copyright © 2020 Ioannis Kapsouras. All rights reserved.
//

import UIKit

class FamiliesViewController: BaseController<FamiliesPresenter> {
	var familiesTableComponent:FamiliesTableComponent?
	var familiesCollectionComponent:FamiliesCollectionComponent?
	var familiesHeaderComponent:FamiliesHeaderComponent?
	@IBOutlet var ViewPhotosWithTable: PhotosTableView!
	@IBOutlet weak var ViewPhotosWithCollection: PhotosCollectionView!
	@IBOutlet weak var ViewHeader: HeaderView!
	
    override func viewDidLoad() {
        super.viewDidLoad()
		guard let butterfliesNavigation = navigationController as? NavigationViewController else {
			print("no proper navigation controller")
			return
		}
		title = Translations.Field
		butterfliesNavigation.setupNavigationBarAppearance(color: Constants.Colors.field(darkMode: false).color, textColor: Constants.Colors.field(darkMode: true).color, fontName: Constants.Fonts.appFont, fontSize: Constants.Fonts.titleControllerSise)
		butterfliesNavigation.setNavigationBarHidden(false, animated: true)
    }
	
	override func viewWillDisappear(_ animated: Bool) {
		super.viewWillDisappear(animated)
		navigationController?.view.setNeedsLayout() // force update layout
		navigationController?.view.layoutIfNeeded()
	}
	
	override func didRotate(from fromInterfaceOrientation: UIInterfaceOrientation) {
		ViewPhotosWithCollection.updateViews()
	}
	
	override func InitializeComponents() -> Array<UiComponent> {
		familiesTableComponent = FamiliesTableComponent(view: ViewPhotosWithTable)
		familiesCollectionComponent = FamiliesCollectionComponent(view: ViewPhotosWithCollection)
		familiesHeaderComponent = FamiliesHeaderComponent(view: ViewHeader)
        return [familiesTableComponent!, familiesCollectionComponent!, familiesHeaderComponent!]
    }
}
