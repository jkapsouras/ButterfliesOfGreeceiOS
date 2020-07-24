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
    
	   var disposeBag:DisposeBag=DisposeBag()
		var backgroundThreadScheduler:BackgroundThreadProtocol
		var mainThreadScheduler:MainThreadProtocol
		var  state:PublishSubject<ViewState> = PublishSubject()

		init(backScheduler:BackgroundThreadProtocol,mainScheduler:MainThreadProtocol)
		{
			backgroundThreadScheduler=backScheduler
			mainThreadScheduler=mainScheduler
		}

		func HandleEvent(uiEvent:UiEvent)
		{

		}

		public func Subscribe(events:Observable<UiEvent>)->Observable<ViewState>
		{
			events
				.subscribe(onNext: { event in self.HandleEvent(uiEvent: event)})
				.disposed(by: disposeBag)

			return state.asObservable().observeOn(mainThreadScheduler.scheduler)
		}
}
