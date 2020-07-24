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
    
    public required init?(coder aDecoder: NSCoder) {
        Components = Array()
        super.init(coder: aDecoder)
    }
    
    var Presenter:P?
    var events:Observable<UiEvent>?
    var Components:Array<UiComponent>?
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        InitViews()
        AddFonts()
        Components = InitializeComponents()
        
        if (Presenter == nil)
        {
            Presenter = (IOC.container?.resolve(P.self))!
            
            events = Observable<UiEvent>.empty()
            
            Components?.forEach{component in
                events=Observable.merge(events!,component.uiEvents)
            }
            
            let state = Presenter?.Subscribe(events: events!).publish()
            
            Components?.forEach{component in
                state?.subscribe(onNext: { viewState in component.renderViewState(viewState: viewState)}).disposed(by: Presenter!.disposeBag)
            }
            
            state?.filter{viewState in viewState is StateTransition}.subscribe(onNext: {viewState in self.TransitionStateReceived(viewState: viewState)}).disposed(by: Presenter!.disposeBag)
            
            state?.connect().disposed(by: Presenter!.disposeBag)
        }
    }
    
    override public func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        LocalizeViews()
    }
    
    override public func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        UpdateViews()
    }
    
    func TransitionStateReceived(viewState:ViewState)->()
    {
        switch viewState {
        case is NavigateToField:
//			let story = UIStoryboard.init(name: "Login", bundle: nil)
//			let ct = story.instantiateInitialViewController()
//			self.modalPresentationStyle = .fullScreen
//			self.present(ct!, animated: true, completion: nil)
			print("navigate to fields")
        default:
            print("default")
        }
    }
    
    func  InitializeComponents()->Array<UiComponent>
    {
        preconditionFailure("This method must be overridden")
    }
    
    func InitViews(){}
    func UpdateViews(){}
    func LocalizeViews(){}
    func AddFonts(){}
}
