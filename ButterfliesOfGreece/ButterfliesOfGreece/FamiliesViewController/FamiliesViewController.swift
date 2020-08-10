//
//  FamiliesViewController.swift
//  ButterfliesOfGreece
//
//  Created by Ioannis Kapsouras on 7/8/20.
//  Copyright © 2020 Ioannis Kapsouras. All rights reserved.
//

import UIKit

class FamiliesViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
		guard let navigation = navigationController else {
			print("no navigation controller")
			return
		}
		if let butterfliesNavigation = navigation as? NavigationViewController {
			title = "families"
			butterfliesNavigation.setupNavigationBarAppearance(color: Constants.Colors.field(darkMode: false).color, textColor: Constants.Colors.field(darkMode: true).color, fontName: Constants.Fonts.appFont, fontSize: Constants.Fonts.titleControllerSise)
			butterfliesNavigation.setNavigationBarHidden(false, animated: true)
		}
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
