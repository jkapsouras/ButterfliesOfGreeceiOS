//
//  MenuViewController.swift
//  ButterfliesOfGreece
//
//  Created by Ioannis Kapsouras on 5/7/20.
//  Copyright © 2020 Ioannis Kapsouras. All rights reserved.
//

import UIKit
import RxCocoa

class MenuViewController: BaseController<MenuPresenter> {
	@IBOutlet weak var ButtonField: UIButton!
	
	var menuComponent:MenuComponent?
	
    override func viewDidLoad() {
        super.viewDidLoad()
    }
	
	override func viewWillLayoutSubviews() {
		ButtonField.centerVerticallyWithPadding(padding: 8)
	}
    
	override func InitViews() {
        ButtonField.setTitleColor(UIColor.black, for: .normal)
    }
    
    override func LocalizeViews() {
        ButtonField.setTitle(Translations.Field, for: .normal)
	}
    
    override func InitializeComponents() -> Array<UiComponent> {
        menuComponent = MenuComponent(field: ButtonField)
        return [menuComponent!]
    }
}
