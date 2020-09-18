//
//  ContributeViewController.swift
//  ButterfliesOfGreece
//
//  Created by Ioannis Kapsouras on 18/9/20.
//  Copyright © 2020 Ioannis Kapsouras. All rights reserved.
//

import UIKit

class ContributeViewController: BaseController<ContributePresenter> {
	@IBOutlet weak var ViewContribute: ContributeView!
	var contributeComponent:ContributeComponent!
	
    override func viewDidLoad() {
        super.viewDidLoad()
		guard let butterfliesNavigation = navigationController as? NavigationViewController else {
			print("no proper navigation controller")
			return
		}
        title = Translations.Contribute
		butterfliesNavigation.setupNavigationBarAppearance(color: Constants.Colors.contribute(darkMode: false).color, textColor: Constants.Colors.contribute(darkMode: true).color, fontName: Constants.Fonts.appFont, fontSize: Constants.Fonts.titleControllerSise)
		butterfliesNavigation.setNavigationBarHidden(false, animated: true)
    }
	
	override func InitializeComponents() -> Array<UiComponent> {
		contributeComponent = ContributeComponent(view: ViewContribute, navigationItem: navigationItem)
		return [contributeComponent!]
	}
}
