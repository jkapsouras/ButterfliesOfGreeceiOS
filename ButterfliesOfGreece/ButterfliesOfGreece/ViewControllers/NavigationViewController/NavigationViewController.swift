//
//  NavigationViewController.swift
//  ButterfliesOfGreece
//
//  Created by Ioannis Kapsouras on 2/8/20.
//  Copyright © 2020 Ioannis Kapsouras. All rights reserved.
//

import UIKit

class NavigationViewController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
	
	func setupNavigationBarAppearance(color: UIColor, textColor: UIColor, fontName: String, fontSize: CGFloat) {
		if #available(iOS 15,*)
		{
			let appearance = UINavigationBarAppearance()
			appearance.configureWithOpaqueBackground()
			appearance.backgroundColor = color;
			let font:UIFont = UIFont(name: fontName, size: fontSize)!
			let navbarTitleAtt = [
				NSAttributedString.Key.font:font,
				NSAttributedString.Key.foregroundColor: textColor
			]
			appearance.titleTextAttributes = navbarTitleAtt
			UINavigationBar.appearance().tintColor = textColor
			UINavigationBar.appearance().standardAppearance = appearance
			UINavigationBar.appearance().scrollEdgeAppearance = appearance
			navigationBar.standardAppearance = appearance
			navigationBar.scrollEdgeAppearance = appearance
		}
		else
		{
			navigationBar.barTintColor = color
			navigationBar.tintColor = textColor
			//		navigationBar.shadowImage = UIImage()
			navigationBar.isTranslucent = false
			
			let font:UIFont = UIFont(name: fontName, size: fontSize)!
			let navbarTitleAtt = [
				NSAttributedString.Key.font:font,
				NSAttributedString.Key.foregroundColor: textColor
			]
			navigationBar.titleTextAttributes = navbarTitleAtt
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
