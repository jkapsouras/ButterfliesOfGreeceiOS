//
//  SpeciesViewController.swift
//  ButterfliesOfGreece
//
//  Created by Apprecot on 20/8/20.
//  Copyright © 2020 Ioannis Kapsouras. All rights reserved.
//

import UIKit

class SpeciesViewController: BaseController<SpeciesPresenter> {
	var speciesTableComponent:SpeciesTableComponent?
	var speciesCollectionComponent:SpeciesCollectionComponent?
	var speciesHeaderComponent:SpeciesHeaderComponent?
	@IBOutlet weak var ViewHeader: HeaderView!
	@IBOutlet weak var TablePhotos: PhotosTableView!
	@IBOutlet weak var CollectionPhotos: PhotosCollectionView!
	
     override func viewDidLoad() {
		   super.viewDidLoad()
		   guard let butterfliesNavigation = navigationController as? NavigationViewController else {
			   print("no proper navigation controller")
			   return
		   }
		   title = "Species" //TODO: specie name from presenter
		   butterfliesNavigation.setupNavigationBarAppearance(color: Constants.Colors.field(darkMode: false).color, textColor: Constants.Colors.field(darkMode: true).color, fontName: Constants.Fonts.appFont, fontSize: Constants.Fonts.titleControllerSise)
		   butterfliesNavigation.setNavigationBarHidden(false, animated: true)
	   }
	   
	   override func didRotate(from fromInterfaceOrientation: UIInterfaceOrientation) {
		   CollectionPhotos.updateViews()
	   }
	   
	   override func InitializeComponents() -> Array<UiComponent> {
		   speciesTableComponent = SpeciesTableComponent(view: TablePhotos)
		   speciesCollectionComponent = SpeciesCollectionComponent(view: CollectionPhotos)
		   speciesHeaderComponent = SpeciesHeaderComponent(view: ViewHeader)
		   return [speciesTableComponent!, speciesCollectionComponent!, speciesHeaderComponent!]
	   }
}
