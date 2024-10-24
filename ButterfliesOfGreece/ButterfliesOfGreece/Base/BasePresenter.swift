//
//  BasePresenter.swift
//  ButterfliesOfGreece
//
//  Created by Ioannis Kapsouras on 5/7/20.
//  Copyright © 2020 Ioannis Kapsouras. All rights reserved.
//
import RxSwift
import Foundation

class BasePresenter{
	
	var disposeBag:DisposeBag?
	let backgroundThreadScheduler:BackgroundThreadProtocol
	let mainThreadScheduler:MainThreadProtocol
	let state:PublishSubject<ViewState> = PublishSubject()
	let emitter:PublishSubject<UiEvent> = PublishSubject()
	
	init(backScheduler:BackgroundThreadProtocol,mainScheduler:MainThreadProtocol)
	{
		disposeBag = DisposeBag()
		backgroundThreadScheduler=backScheduler
		mainThreadScheduler=mainScheduler
	}
	
	func HandleEvent(uiEvents:UiEvent)
	{
		
	}
	
	func Subscribe(events:Observable<UiEvent>)->Observable<ViewState>
	{
		Observable.merge(events,emitter.asObservable())
			.subscribe(onNext: { event in self.HandleEvent(uiEvents: event)})
			.disposed(by: disposeBag!)
		return state.asObservable().observeOn(mainThreadScheduler.scheduler)
	}
	
	func setupEvents(){
		fatalError("Must Override")
	}
	
	func unSubscribe(){
		disposeBag = nil
	}
}
