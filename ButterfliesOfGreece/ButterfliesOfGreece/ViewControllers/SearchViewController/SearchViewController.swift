//
//  SearchViewController.swift
//  ButterfliesOfGreece
//
//  Created by Ioannis Kapsouras on 5/9/20.
//  Copyright © 2020 Ioannis Kapsouras. All rights reserved.
//

import UIKit

class SearchViewController: BaseController<SearchPresenter>, UISearchBarDelegate {
	var searchResultComponent:SearchResultComponent?
	var searchHeaderComponent:SearchHeaderComponent?
	let searchBar = UISearchBar()
	@IBOutlet weak var ViewResults: PhotosTableView!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		guard let butterfliesNavigation = navigationController as? NavigationViewController else {
			print("no proper navigation controller")
			return
		}
		butterfliesNavigation.setupNavigationBarAppearance(color: Constants.Colors.field(darkMode: false).color, textColor: Constants.Colors.field(darkMode: true).color, fontName: Constants.Fonts.appFont, fontSize: Constants.Fonts.titleControllerSise)
		butterfliesNavigation.setNavigationBarHidden(false, animated: true)
		
		searchBar.delegate = self
		searchBar.tintColor = Constants.Colors.introduction(darkMode: false).color
		searchBar.placeholder = "search"
		searchBar.showsCancelButton = false
		let textFieldInsideUISearchBar = searchBar.value(forKey: "searchField")
		if let textField = textFieldInsideUISearchBar as! UITextField?{
			textField.textColor = Constants.Colors.introduction(darkMode: true).color
		}
		navigationItem.titleView = searchBar
		searchBar.becomeFirstResponder()
		view.backgroundColor = Constants.Colors.appWhite.color
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		view.setNeedsLayout() // force update layout
		view.layoutIfNeeded()
	}
	
	override func viewWillDisappear(_ animated: Bool) {
		super.viewWillDisappear(animated)
		navigationController?.view.setNeedsLayout() // force update layout
		navigationController?.view.layoutIfNeeded()
	}
	
	override func InitializeComponents() -> Array<UiComponent> {
		searchResultComponent = SearchResultComponent(view: ViewResults)
		searchHeaderComponent = SearchHeaderComponent(searchBar: searchBar)
		return [searchResultComponent!, searchHeaderComponent!]
	}
}
