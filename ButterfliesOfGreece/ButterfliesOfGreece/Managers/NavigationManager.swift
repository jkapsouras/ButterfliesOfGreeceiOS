//
//  NavigationManager.swift
//  ButterfliesOfGreece
//
//  Created by Ioannis Kapsouras on 7/8/20.
//  Copyright © 2020 Ioannis Kapsouras. All rights reserved.
//

import Foundation
import UIKit

struct NavigationManager {
	let navigationController: NavigationViewController
	
	init(controller:NavigationViewController){
		navigationController=controller
	}
	
	let menuTransitionsControllers: [MenuViewState:String] = [
		.toField: "FamiliesViewController",
		.toIntroduction: "not implemented yet",
		.toAbout: "not implemented yet",
		.toContribute: "not implemented yet",
		.toEndangered: "not implemented yet",
		.toLegal: "not implemented yet",
		.toOfflineRecognition: "not implemented yet",
		.toOnlineRecognition: "not implemented yet"]
	
	let menuTransitionsStoryboards: [MenuViewState:String] = [
		.toField: "Families",
		.toIntroduction: "not implemented yet",
		.toAbout: "not implemented yet",
		.toContribute: "not implemented yet",
		.toEndangered: "not implemented yet",
		.toLegal: "not implemented yet",
		.toOfflineRecognition: "not implemented yet",
		.toOnlineRecognition: "not implemented yet"]
	
	func MenuTransition(menuTransition: MenuViewState) {
		guard let currentStoryboardName = menuTransitionsStoryboards[menuTransition] else{
			print("Storyboard name not found")
			return
		}
		guard let currentControllerName = menuTransitionsControllers[menuTransition] else{
			print("Controller name not found")
			return
		}
		let storyboard = UIStoryboard.init(name: currentStoryboardName, bundle: nil)
		let vc = storyboard.instantiateViewController(identifier: currentControllerName)
		let vcType = type(of: vc)
		let vcExisits = navigationController.viewControllers.contains{$0.isKind(of: vcType)}
		if(vcExisits){
			navigationController.popToViewController(vc, animated: true)
		}
		else{
			navigationController.pushViewController(vc, animated: true)
		}
	}
}
