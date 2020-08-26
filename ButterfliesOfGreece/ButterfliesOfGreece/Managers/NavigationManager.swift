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
	
	func MenuTransition(menuTransition: MenuViewState) {
		guard let currentStoryboardName = menuTransition.toStoryboardName else{
			print("Storyboard name not found")
			return
		}
		guard let currentControllerName = menuTransition.toViewControllerName else{
			print("Controller name not found")
			return 
		}
		navigateToController(storyboardName: currentStoryboardName, controllerName: currentControllerName)
	}
	
	func FamilyTransition(familyTransition: FamiliesViewStates) {
		guard let currentStoryboardName = familyTransition.toStoryboardName else{
			print("Storyboard name not found")
			return
		}
		guard let currentControllerName = familyTransition.toViewControllerName else{
			print("Controller name not found")
			return
		}
		navigateToController(storyboardName: currentStoryboardName, controllerName: currentControllerName)
	}
	
	func SpecieTransition(specieTransition: SpeciesViewStates) {
		guard let currentStoryboardName = specieTransition.toStoryboardName else{
			print("Storyboard name not found")
			return
		}
		guard let currentControllerName = specieTransition.toViewControllerName else{
			print("Controller name not found")
			return
		}
		navigateToController(storyboardName: currentStoryboardName, controllerName: currentControllerName)
	}
	
	func PhotosTransition(photosTransitions: PhotosViewStates) {
		guard let currentStoryboardName = photosTransitions.toStoryboardName else{ 
			print("Storyboard name not found")
			return
		}
		guard let currentControllerName = photosTransitions.toViewControllerName else{
			print("Controller name not found")
			return
		}
		let storyboard = UIStoryboard.init(name: currentStoryboardName, bundle: nil)
		let vc = storyboard.instantiateViewController(identifier: currentControllerName)
		navigationController.present(vc, animated: true, completion: nil)
	}
	
	func navigateToController(storyboardName:String, controllerName:String){
		let storyboard = UIStoryboard.init(name: storyboardName, bundle: nil)
		let vc = storyboard.instantiateViewController(identifier: controllerName)
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
