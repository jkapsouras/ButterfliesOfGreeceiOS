//
//  AppDelegate.swift
//  ButterfliesOfGreece
//
//  Created by Ioannis Kapsouras on 5/7/20.
//  Copyright © 2020 Ioannis Kapsouras. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift
import AppCenter
import AppCenterAnalytics
import AppCenterCrashes

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

	var window: UIWindow?


	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
		// Override point for customization after application launch.
		AppCenter.start(withAppSecret: "7e373fe2-791f-4620-9efa-5a165d945886", services: [
			Analytics.self,
		 Crashes.self
	   ]) 
		
		IQKeyboardManager.shared.enable = true;
		IQKeyboardManager.shared.enableAutoToolbar = true;
		IQKeyboardManager.shared.previousNextDisplayMode = .alwaysShow
		IQKeyboardManager.shared.shouldToolbarUsesTextFieldTintColor = true;
		IQKeyboardManager.shared.toolbarDoneBarButtonItemText = Translations.Done
		
		let pageControl = UIPageControl.appearance()
		pageControl.pageIndicatorTintColor = Constants.Colors.field(darkMode: true).color
		pageControl.currentPageIndicatorTintColor = Constants.Colors.about(darkMode: true).color
		pageControl.backgroundColor = UIColor.clear
		
		IOC.container = IOC.RegisterElements()
		return true
	}
	

	// MARK: UISceneSession Lifecycle

	@available(iOS 13.0, *)
	func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
		// Called when a new scene session is being created.
		// Use this method to select a configuration to create the new scene with.
		return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
	}

	@available(iOS 13.0, *)
	func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
		// Called when the user discards a scene session.
		// If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
		// Use this method to release any resources that were specific to the discarded scenes, as they will not return.
	}


}

