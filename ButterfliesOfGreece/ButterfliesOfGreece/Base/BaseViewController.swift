//
//  BaseViewController.swift
//  ButterfliesOfGreece
//
//  Created by Ioannis Kapsouras on 24/7/20.
//  Copyright © 2020 Ioannis Kapsouras. All rights reserved.
//

import Foundation
import UIKit
import RxSwift

class BaseController<P> : UIViewController where P : BasePresenter
{
	let disposeBag:DisposeBag = DisposeBag()
	var navigationManager:NavigationManager?
	
	public required init?(coder aDecoder: NSCoder) {
		Components = Array()
		super.init(coder: aDecoder)
	}
	
	var Presenter:P?
	var events:Observable<UiEvent>?
	var Components:Array<UiComponent>?
	
	override public func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		InitViews()
		AddFonts()
		Components = InitializeComponents()
		
		if(navigationController != nil && navigationController is NavigationViewController){
			let navController = navigationController as! NavigationViewController
			navigationManager = NavigationManager(controller: navController)
		}
		else{
			navigationManager = NavigationManager(controller: NavigationViewController())
		}
		
		
		if (Presenter == nil)
		{
			Presenter = (IOC.container?.resolve(P.self))!
			
			events = Observable<UiEvent>.empty()
			
			Components?.forEach{component in
				events=Observable.merge(events!,component.uiEvents)
			}
			
			let state = Presenter?.Subscribe(events: events!).publish()
			
			Components?.forEach{component in
				state?.subscribe(onNext: { viewState in component.renderViewState(viewState: viewState)}).disposed(by: Presenter!.disposeBag!)
			}
			
			state?.filter{viewState in viewState.isTransition}.subscribe(onNext: {viewState in self.TransitionStateReceived(viewState: viewState)}).disposed(by: Presenter!.disposeBag!)
			
			state?.connect().disposed(by: Presenter!.disposeBag!)
			Presenter?.setupEvents()
		}
		LocalizeViews()
	}
	
	override public func viewDidLayoutSubviews() {
		super.viewDidLayoutSubviews()
		UpdateViews()
	}
	
	override func viewWillDisappear(_ animated: Bool) {
		unSubscribe()
	}
	
	func TransitionStateReceived(viewState:ViewState)->()
	{
		guard  navigationController != nil else{
			print("There is no navigation controller!")
			return
		}
		switch viewState {
		case let menuTransition as MenuViewState:
			navigationManager!.MenuTransition(menuTransition: menuTransition)
		case let familiesTransition as FamiliesViewStates:
			navigationManager!.FamilyTransition(familyTransition: familiesTransition)
		case let speciesTransition as SpeciesViewStates:
			navigationManager!.SpecieTransition(specieTransition: speciesTransition)
		case let photosTransition as PhotosViewStates:
			navigationManager!.PhotosTransition(photosTransitions: photosTransition)
		case let headerTransition as HeaderViewViewStates:
			navigationManager!.HeaderTransition(headerTransition: headerTransition)
		case let searchTransition as SearchViewStates:
			navigationManager!.searchTransition(searchTransition: searchTransition)
		case let printToPdfTransition as PrintToPdfViewStates:
			navigationManager!.printToPdfTransition(pdfTransition: printToPdfTransition)
		default:
			print("default")
		}
	}
	
	func  InitializeComponents()->Array<UiComponent>
	{
		preconditionFailure("This method must be overridden")
	}
	
	func unSubscribe()
	{
		guard let presenter = Presenter else{
			print("presenter already nil")
			return
		}
		presenter.unSubscribe()
		Presenter = nil
	}
	
	func InitViews(){}
	func UpdateViews(){}
	func LocalizeViews(){}
	func AddFonts(){}
}
